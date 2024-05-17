// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../temple_list/domain/entities/itms_response.dart';
import '../../domain/entities/live_events.dart';
import '../widgets/live_stream.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/app_header.dart';
import '/config/common/widgets/bottom_sheet.dart';
import '/config/common/widgets/cloud_arc.dart';
import '/config/common/widgets/navigation_drawer.dart';
import '/config/common/widgets/no_data_available.dart';
import '/config/constants.dart';
import '/core/models/live_stream.dart';
import '/features/dashboard/presentation/bloc/live_events/live_events_bloc.dart';

class TempleLiveTeleCasts extends StatefulWidget {
  final ItmsResponseEntity? templeData;
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
      appBar: appHeader(
        context: context,
        body: LocaleText("live_events",
            textAlign: TextAlign.center, style: appbarTextStyleLarge(theme)),
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
                img: NetworkImages.noEventAvailable);
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
                          List<LiveEventsEntity>? liveEvents = state.liveEvents!
                              .cast<LiveEventsEntity>()
                              .where(
                                (element) => element.scrollData!.any(
                                  (data) => liveStreamType[index].liveurlType ==
                                          "C"
                                      ? (data.eventUrl!.youtubeLiveUrl != "" &&
                                          data.liveurl ==
                                              liveStreamType[index].liveUrl &&
                                          data.liveurlType ==
                                              liveStreamType[index]
                                                  .liveurlType &&
                                          data.publishedUpto!
                                              .isBefore(DateTime.now()))
                                      : liveStreamType[index].liveurlType == "F"
                                          ? (data.eventUrl!.youtubeLiveUrl !=
                                                  "" &&
                                              data.liveurl ==
                                                  liveStreamType[index]
                                                      .liveUrl &&
                                              data.liveurlType ==
                                                  liveStreamType[index]
                                                      .liveurlType &&
                                              data.publishedUpto!
                                                  .isAfter(DateTime.now()))
                                          : (data.eventUrl!.youtubeLiveUrl !=
                                                  "" &&
                                              data.liveurl ==
                                                  liveStreamType[index]
                                                      .liveUrl &&
                                              data.liveurlType ==
                                                  liveStreamType[index]
                                                      .liveurlType),
                                ),
                              )
                              .toList();

                          debugPrint(
                              //"url  : ${liveEvents[0].scrollData![1].eventDesc}\n"
                              "liveurlType : ${liveStreamType[index].liveUrl}\n"
                              "liveurlType : ${liveStreamType[index].steamType.split("\n")}\n"
                              "Data Count : ${liveEvents.length}\n"
                              "liveurlType : ${liveStreamType[index].liveurlType}\n");
                          buildBottomSheet(
                            context,
                            liveEvents,
                            'live_events',
                            TempleLiveStreams(liveEvents),
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
              img: NetworkImages.noLiveAvailable);
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
