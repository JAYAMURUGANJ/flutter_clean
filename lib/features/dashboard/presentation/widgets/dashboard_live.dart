// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../temple_details/presentation/widgets/main_tower.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/bottom_sheet.dart';
import '/config/common/widgets/text_widgets.dart';
import '/config/constants.dart';
import '/features/dashboard/domain/entities/live_events.dart';
import '/features/dashboard/presentation/bloc/live_events/live_events_bloc.dart';
import 'live_stream.dart';

class DashboardLive extends StatefulWidget {
  String? liveurl;
  String? liveurlType;
  DashboardLive({
    Key? key,
    this.liveurl,
    this.liveurlType,
  }) : super(key: key);

  @override
  _DashboardLiveState createState() => _DashboardLiveState();
}

class _DashboardLiveState extends State<DashboardLive> {
  @override
  void initState() {
    BlocProvider.of<LiveEventsBloc>(context).add(GetLiveEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveEventsBloc, LiveEventsState>(
      builder: (context, state) {
        if (state is LiveEventsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is LiveEventsLoaded) {
          List<LiveEventsEntity>? liveEvents = [];

          for (var element in state.liveEvents!.cast<LiveEventsEntity>()) {
            // Check if the temple IDs match or if the temple ID is null

            var filteredScrollData = element.scrollData!.where((data) {
              return data.eventUrl!.youtubeLiveUrl != "" &&
                  data.liveurl == widget.liveurl &&
                  data.liveurlType == widget.liveurlType &&
                  data.publishedUpto!.isBefore(DateTime.now());
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

          return Visibility(
            visible: liveEvents.isNotEmpty,
            child: Padding(
                padding: defaultPadding,
                child: SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeading(context, "whats_new"),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: liveEvents.length,
                          itemExtent: 85,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: _buildShowVideoBottomSheet(
                                liveEvents[i],
                              ),
                            );
                          },
                        ),
                      ),
                      5.ph,
                    ],
                  ),
                )),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _buildShowVideoBottomSheet(LiveEventsEntity liveEvents) {
    return GestureDetector(
      onTap: () {
        buildBottomSheet(
          context,
          liveEvents,
          'live_events',
          TempleLiveStreams(
            liveEvents: [liveEvents],
            liveurlType: "C",
            liveurl: "Y",
          ),
        );
      },
      child: LiveEventShowCard(
        event: liveEvents,
      ),
    );
  }
}

class LiveEventShowCard extends StatefulWidget {
  LiveEventsEntity event;

  LiveEventShowCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<LiveEventShowCard> createState() => _LiveEventShowCardState();
}

class _LiveEventShowCardState extends State<LiveEventShowCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        mainTower(widget.event, 10),
        Image.asset(
          LocalImages().play,
        ),
      ],
    );
  }
}
