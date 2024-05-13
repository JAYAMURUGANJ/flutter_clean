// ignore_for_file: library_private_types_in_public_api

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:intl/intl.dart';
import 'package:news_app_clean_architecture/features/event_calendar/presentation/bloc/calendar_event/calendar_event_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/itms_response.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../config/common/widgets/navigation_drawer.dart';
import '../../../../config/constants.dart';
import '../../data/model/calendar_event.dart';
import '../../data/model/calendar_event_details.dart';
import '../../domain/entities/calendar_event.dart';
import '../bloc/calendar_event_details/calendar_event_details_bloc.dart';
import '../widgets/utils.dart';
import '/config/common/widgets/app_header.dart';

class TempleEventCalendar extends StatefulWidget {
  final ItmsResponseEntity? templeData;
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
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _isExpansionOpen = false;
    _selectedEvents.value = _getEventsForDay(DateTime.now());
    //
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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        //
        _isExpansionOpen = false;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic theme = Theme.of(context);
    return Scaffold(
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
          if (state is CalendarEventLoaded) {
            dataMapList = state.calendarEvent! as List<CalendarEvent>;
          }
          return Column(
            children: [
              if (widget.templeData?.templeId == null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    Locales.lang == "en"
                        ? widget.templeData?.templeName?.split(',')[0] ?? ''
                        : widget.templeData?.ttempleName?.split(',')[0] ?? "",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  // Use `CalendarStyle` to customize the UI
                  outsideDaysVisible: false,
                ),
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                  String formatedMonth =
                      DateFormat("yyyyMM").format(focusedDay);

                  BlocProvider.of<CalendarEventBloc>(context).add(
                      GetCalendarEvent(
                          templeId:
                              widget.templeData?.templeId.toString() ?? "",
                          filterMonth: formatedMonth));
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<CalendarEvent>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    print("values $value");
                    List<FestivalDatum> festivalData = [];
                    if (value.isNotEmpty) {
                      festivalData = value[0].festivalData!;
                    }
                    return BlocBuilder<CalendarEventDetailsBloc,
                        CalendarEventDetailsState>(
                      builder: (context, detailsState) {
                        List<CalendarEventDetails>? detailsList;
                        if (detailsState is CalendarEventDetailsLoaded) {
                          detailsList = detailsState.calendarEventDetails
                              as List<CalendarEventDetails>;
                        }
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
                              child: ExpansionTile(
                                onExpansionChanged: (isExpansionOpen) {
                                  setState(() {
                                    _isExpansionOpen = isExpansionOpen;
                                  });
                                  if (isExpansionOpen) {
                                    BlocProvider.of<CalendarEventDetailsBloc>(
                                            context)
                                        .add(GetCalendarEventDetails(
                                      festivalCode:
                                          festivalData[index].festivalCode,
                                      festivalDate:
                                          value[0].calendarDays.toString(),
                                    ));
                                  }
                                },
                                title: Text(
                                    '${DateFormat("dd-MM-yyy").format(value[0].calendarDays!)}\n${festivalData[index].festivalName}'),
                                children: _isExpansionOpen
                                    ? detailsState is CalendarEventDetailsLoaded
                                        ? [
                                            Text(detailsList![0]
                                                .templeName
                                                .toString()),
                                            Text(
                                                '${detailsList[0].festivalInfo![0].festivalDetails}'),
                                            Text(
                                                'Time : ${detailsList[0].festivalInfo![0].festivalFromtime} - ${detailsList![0].festivalInfo![0].festivalTotime}'),
                                          ]
                                        : []
                                    : [],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  DateTime convertStringEventToDateTime(String date) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
