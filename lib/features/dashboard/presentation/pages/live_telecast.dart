// ignore_for_file: must_be_immutable, unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/config/common/extensions.dart';
import '/config/common/widgets/app_header.dart';
import '/config/common/widgets/bottom_sheet.dart';
import '/config/common/widgets/cloud_arc.dart';
import '/config/common/widgets/navigation_drawer.dart';
import '/config/common/widgets/no_data_available.dart';
import '/config/constants.dart';
import '/core/models/live_stream.dart';
import '/features/dashboard/presentation/bloc/live_events/live_events_bloc.dart';
import '../../../temple_list/domain/entities/temple_list.dart';
import '../../domain/entities/live_events.dart';
import '../widgets/live_stream.dart';

class TempleLiveTeleCasts extends StatefulWidget {
  final TempleEntity? templeData;
  const TempleLiveTeleCasts({
    Key? key,
    this.templeData,
  }) : super(key: key);

  @override
  State<TempleLiveTeleCasts> createState() => _TempleLiveTeleCastsState();
}

class _TempleLiveTeleCastsState extends State<TempleLiveTeleCasts> {
  @override
  Widget build(BuildContext context) {
    dynamic theme = Theme.of(context);
    return Scaffold(
      appBar: (widget.templeData?.templeId != null)
          ? null
          : appHeader(
              context: context,
              body: LocaleText("live_events",
                  textAlign: TextAlign.center,
                  style: appbarTextStyleLarge(theme)),
              trailing: IconButton(
                onPressed: () => buildNavigationDrawer(context),
                icon: const Icon(Icons.menu),
              ),
            ),
      body: BlocBuilder<LiveEventsBloc, LiveEventsState>(
        builder: (context, state) {
          if (state is LiveEventsLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is LiveEventsSomthingWentWrong) {
            return DataNotAvailable(
                error: "Somthing Went Wrong",
                img: LocalImages().noLiveAvailable);
          }
          if (state is LiveEventsLoaded) {
            return Stack(
              children: [
                //bottom wave design
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 180),
                    painter: CloudArcPainter(
                        themeColor: Theme.of(context).colorScheme.primary),
                  ),
                ),
                // live telecasting categorys
                Center(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 8.0,
                    ),
                    padding: const EdgeInsets.all(4.0),
                    itemCount: liveStreamType.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          RegExp regExp = RegExp(
                            r"(?<=channel\/)(.*?)(?=\/live)",
                            caseSensitive: false,
                          );
                          final today = DateTime.now().today;
                          List<LiveEventsEntity>? liveEvents = [];

                          for (var element
                              in state.liveEvents!.cast<LiveEventsEntity>()) {
                            // Check if the temple IDs match or if the temple ID is null
                            if (widget.templeData?.templeId == null ||
                                element.templeId ==
                                    widget.templeData!.templeId) {
                              var filteredScrollData =
                                  element.scrollData!.where((data) {
                                final publishedFrom = DateTime(
                                    data.publishedFrom!.year,
                                    data.publishedFrom!.month,
                                    data.publishedFrom!.day);
                                final publishedTo = DateTime(
                                    data.publishedUpto!.year,
                                    data.publishedUpto!.month,
                                    data.publishedUpto!.day);
                                return liveStreamType[index].liveurlType == "U"
                                    ? regExp.hasMatch(data.eventUrl!)
                                    : data.eventUrl!.youtubeLiveUrl != "" &&
                                        data.liveurl ==
                                            liveStreamType[index].liveUrl &&
                                        data.liveurlType ==
                                            liveStreamType[index].liveurlType &&
                                        ((liveStreamType[index].liveurlType ==
                                                    "C" ||
                                                liveStreamType[index]
                                                        .liveurlType ==
                                                    "U")
                                            ? data.publishedUpto!
                                                .isBefore(DateTime.now())
                                            : (publishedFrom == today ||
                                                publishedTo == today ||
                                                data.publishedUpto!
                                                    .isAfter(DateTime.now())));
                              }).toList();

                              if (filteredScrollData.isNotEmpty) {
                                liveEvents.add(LiveEventsEntity(
                                  templeId: element.templeId,
                                  ttempleName: element.ttempleName,
                                  templeName: element.templeName,
                                  maintowerImage: element.maintowerImage,
                                  scrollData: filteredScrollData,
                                ));
                              }
                            }
                          }
                          buildBottomSheet(
                            context,
                            liveEvents,
                            'live_events',
                            TempleLiveStreams(
                              liveEvents: liveEvents,
                              liveurlType: liveStreamType[index].liveurlType,
                              liveurl: liveStreamType[index].liveUrl,
                            ),
                          );
                        },
                        child: LiveStreamDataVideoCard(
                          liveStreamType: liveStreamType[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return DataNotAvailable(
              error: "Live Telecasting not available",
              img: LocalImages().noLiveAvailable);
        },
      ),
    );
  }
}

class LiveStreamDataVideoCard extends StatelessWidget {
  LiveSteamType liveStreamType;
  LiveStreamDataVideoCard({
    Key? key,
    required this.liveStreamType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 160,
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              liveStreamType.imageLink,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            Locales.lang == "en"
                ? liveStreamType.steamType
                : liveStreamType.tsteamType,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
