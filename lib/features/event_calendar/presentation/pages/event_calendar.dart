// ignore_for_file: library_private_types_in_public_api

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:intl/intl.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/config/common/widgets/network_aware.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

import '/config/common/widgets/app_header.dart';
import '/config/common/widgets/navigation_drawer.dart';
import '/config/common/widgets/no_data_available.dart';
import '/config/common/widgets/something_went_wrong.dart';
import '/config/constants.dart';
import '/features/event_calendar/presentation/bloc/calendar_event/calendar_event_bloc.dart';
import '../../../temple_list/domain/entities/temple_list.dart';
import '../../data/model/calendar_event.dart';
import '../../data/model/calendar_event_details.dart';
import '../../domain/entities/calendar_event.dart';
import '../bloc/calendar_event_details/calendar_event_details_bloc.dart';
import '../widgets/utils.dart';

class TempleEventCalendar extends StatefulWidget {
  final TempleEntity? templeData;
  const TempleEventCalendar({Key? key, this.templeData}) : super(key: key);

  @override
  _TempleEventCalendarState createState() => _TempleEventCalendarState();
}

class _TempleEventCalendarState extends State<TempleEventCalendar> {
  late final ValueNotifier<List<CalendarEvent>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool _isExpansionOpen = false;
  LinkedHashMap<DateTime, List<CalendarEvent>> kEvents =
      LinkedHashMap<DateTime, List<CalendarEvent>>();
  List<CalendarEvent> dataMapList = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));
    _isExpansionOpen = false;
    _selectedEvents.value = _getEventsForDay(DateTime.now());

    String formatedMonth = DateFormat("yyyyMM").format(_selectedDay!);
    BlocProvider.of<CalendarEventBloc>(context).add(GetCalendarEvent(
        templeId: widget.templeData?.templeId.toString() ?? "",
        filterMonth: formatedMonth));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    kEvents = LinkedHashMap<DateTime, List<CalendarEvent>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(getEvent());
    return kEvents[day] ?? [];
  }

  Map<DateTime, List<CalendarEvent>> getEvent() {
    var eventDayMap = <DateTime, List<CalendarEvent>>{};
    List<CalendarEvent> list = dataMapList
        .where((element) => (element.festivalData!.isNotEmpty))
        .toList();
    final releaseDateMap = list.groupBy((m) =>
        convertStringEventToDateTime('${m.calendarDays!} 00:00:00.000Z'));
    eventDayMap.addAll(releaseDateMap);
    return eventDayMap;
  }

  _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        resetRangeSelection();
        _isExpansionOpen = false;
      });
    }
    _selectedEvents.value = _getEventsForDay(selectedDay);
  }

  void resetRangeSelection() {
    _rangeStart = null;
    _rangeEnd = null;
    _rangeSelectionMode = RangeSelectionMode.toggledOff;
  }

  @override
  Widget build(BuildContext context) {
    dynamic theme = Theme.of(context);
    return NetworkAware(
      child: Scaffold(
        appBar: (widget.templeData?.templeId != null)
            ? null
            : appHeader(
                context: context,
                body: LocaleText("events",
                    textAlign: TextAlign.center,
                    style: appbarTextStyleLarge(theme)),
                trailing: IconButton(
                  onPressed: () => buildNavigationDrawer(context),
                  icon: const Icon(Icons.menu),
                ),
              ),
        body: BlocBuilder<CalendarEventBloc, CalendarEventState>(
          builder: (context, state) {
            if (state is CalendarEventsLoading) {
              return const ShimmerCalendar();
            }
            if (state is CalendarEventLoadingSomthingWentWrong) {
              String error = state.responseStatus!;
              return somthingWentWrong(context, error,
                  errorIcon: LocalImages().noEventAvailable);
            }
            if (state is CalendarEventLoadingError) {
              String error = state.responseStatus.toString();
              return somthingWentWrong(context, error);
            }

            if (state is CalendarEventLoaded) {
              dataMapList = state.calendarEvent! as List<CalendarEvent>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.templeData?.templeId != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Text(
                        Locales.lang == "en"
                            ? widget.templeData?.templeName?.split(',')[0] ?? ''
                            : widget.templeData?.ttempleName?.split(',')[0] ??
                                "",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  TableCalendar<CalendarEvent>(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onCalendarCreated: ((pageController) {
                      _onDaySelected(_selectedDay!, _focusedDay);
                    }),
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: _onDaySelected,
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.sunday) {
                          final text = DateFormat.E().format(day);
                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14,
                              ),
                            ),
                          );
                        } else {
                          final text = DateFormat.E().format(day);
                          return Center(
                            child: Text(
                              text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }
                      },
                      todayBuilder: (context, date, _) {
                        return Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              date.day.toString(),
                              style: const TextStyle(color: Colors.white),
                            ));
                      },
                    ),
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                      String formatedMonth = getMonthYear(focusedDay);
                      setState(() {
                        if (focusedDay.month != DateTime.now().month) {
                          //first day of the month
                          _selectedDay =
                              DateTime(focusedDay.year, focusedDay.month, 1);
                        } else {
                          //currend day of the month
                          _selectedDay = DateTime.now();
                        }
                      });

                      BlocProvider.of<CalendarEventBloc>(context).add(
                          GetCalendarEvent(
                              templeId: widget.templeData?.templeId.toString(),
                              filterMonth: formatedMonth));
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Flexible(
                    child: ValueListenableBuilder<List<CalendarEvent>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        // Display details based on _selectedEvents

                        List<FestivalDatum> festivalData = [];
                        if (value.isNotEmpty) {
                          festivalData = value[0].festivalData!;
                        }
                        return BlocBuilder<CalendarEventBloc,
                            CalendarEventState>(
                          builder: (context, state) {
                            if (state.calendarEvent is CalendarEventsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (state is CalendarEventLoaded &&
                                festivalData.isNotEmpty) {
                              return ListView.builder(
                                itemCount: festivalData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: BlocBuilder<CalendarEventDetailsBloc,
                                        CalendarEventDetailsState>(
                                      builder: (context, detailsState) {
                                        List<CalendarEventDetails>? detailsList;
                                        if (detailsState
                                            is CalendarEventDetailsLoaded) {
                                          detailsList =
                                              detailsState.calendarEventDetails
                                                  as List<CalendarEventDetails>;
                                        }
                                        return ExpansionTile(
                                          onExpansionChanged:
                                              (isExpansionOpen) {
                                            setState(() {
                                              _isExpansionOpen =
                                                  isExpansionOpen;
                                            });
                                            if (isExpansionOpen) {
                                              BlocProvider.of<
                                                          CalendarEventDetailsBloc>(
                                                      context)
                                                  .add(GetCalendarEventDetails(
                                                festivalCode:
                                                    festivalData[index]
                                                        .festivalCode,
                                                festivalDate: value[0]
                                                    .calendarDays
                                                    .toString(),
                                              ));
                                            }
                                          },
                                          leading: Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Text(
                                                  value[0]
                                                      .calendarDays!
                                                      .day
                                                      .toString(),
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.calendar_today,
                                                size: 50,
                                              ),
                                            ],
                                          ),
                                          title: Text(festivalData[index]
                                              .festivalName
                                              .toString()),
                                          children: _isExpansionOpen
                                              ? detailsState
                                                      is CalendarEventDetailsLoaded
                                                  ? [
                                                      widget.templeData
                                                                  ?.templeId ==
                                                              null
                                                          ? Text(
                                                              detailsList![0]
                                                                  .templeName!
                                                                  .toString(),
                                                              softWrap: true,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              maxLines: 3,
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      Text(
                                                          '${detailsList![0].festivalInfo![0].festivalDetails}'),
                                                      Text(
                                                          'Time : ${detailsList[0].festivalInfo![0].festivalFromtime} - ${detailsList[0].festivalInfo![0].festivalTotime}'),
                                                    ]
                                                  : []
                                              : [],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }

                            return SingleChildScrollView(
                              child: DataNotAvailable(
                                error: "no_calendar_events",
                                img: LocalImages().noEventAvailable,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  DateTime convertStringEventToDateTime(String date) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  }

  String getMonthYear(DateTime dateTime) {
    return DateFormat('yyyyMM').format(dateTime).toString();
  }
}

class ShimmerCalendar extends StatelessWidget {
  const ShimmerCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.left_chevron,
                    size: 30,
                  ),
                  15.pw,
                  const Card(
                    child: SizedBox(
                      width: 100,
                      height: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Card(
                    child: SizedBox(
                      width: 80,
                      height: 25,
                    ),
                  ),
                  15.pw,
                  const Icon(
                    CupertinoIcons.right_chevron,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
          10.ph,
          SizedBox(
            height: 20,
            width: MediaQuery.sizeOf(context).width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(right: 3.0),
                  child: Card(
                    child: SizedBox(
                      width: 36,
                    ),
                  ),
                );
              },
            ),
          ),
          20.ph,
          Expanded(
            child: GridView.builder(
              itemCount: 30, // Assuming a month with 30 days
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // 7 days in a week
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 12.0,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Card(
                  child: SizedBox(
                    height: 80,
                    child: ListTile(
                      leading: Icon(
                        Icons.calendar_today,
                        size: 50,
                      ),
                      title: Card(
                        child: SizedBox(
                          width: 80,
                          height: 12,
                        ),
                      ),
                      trailing: Icon(
                        CupertinoIcons.chevron_down,
                        size: 30,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
