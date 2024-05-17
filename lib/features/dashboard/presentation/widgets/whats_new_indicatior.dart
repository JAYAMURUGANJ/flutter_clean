// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/common/widgets/bottom_sheet.dart';
import '../../../../config/common/widgets/text_widgets.dart';
import '../../../temple_details/presentation/widgets/main_tower.dart';
import '/config/common/extensions.dart';
import '/config/constants.dart';
import '/features/dashboard/domain/entities/live_events.dart';
import '/features/dashboard/presentation/bloc/live_events/live_events_bloc.dart';
import 'live_stream.dart';

class WhatsNewIndicatior extends StatefulWidget {
  String? liveurl;
  String? liveurlType;
  WhatsNewIndicatior({
    Key? key,
    this.liveurl,
    this.liveurlType,
  }) : super(key: key);

  @override
  _WhatsNewIndicatiorState createState() => _WhatsNewIndicatiorState();
}

class _WhatsNewIndicatiorState extends State<WhatsNewIndicatior> {
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
          List<LiveEventsEntity>? liveEvents = state.liveEvents!
              .cast<LiveEventsEntity>()
              .where(
                (element) => element.scrollData!.any(
                  (data) =>
                      data.eventUrl!.youtubeLiveUrl != "" &&
                      data.liveurl == widget.liveurl &&
                      data.liveurlType == widget.liveurlType &&
                      data.publishedUpto!.isBefore(DateTime.now()),
                ),
              )
              .toList();
          return Visibility(
            visible: liveEvents.isNotEmpty,
            child: Padding(
                padding: defaultPadding,
                child: SizedBox(
                  height: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeading(context, "whats_new"),
                      5.ph,
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: liveEvents.length,
                          itemExtent: 90,
                          itemBuilder: (context, i) {
                            return Visibility(
                              visible: liveEvents[i].scrollData!.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: _buildShowVideoBottomSheet(
                                  liveEvents[i],
                                ),
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

  _buildShowVideoBottomSheet(LiveEventsEntity liveEvents) => GestureDetector(
        onTap: () => buildBottomSheet(
          context,
          liveEvents,
          'live_events',
          TempleLiveStreams([liveEvents]),
        ),
        child: LiveEventShowCard(
          event: liveEvents,
        ),
      );
}

class LiveEventShowCard extends StatelessWidget {
  LiveEventsEntity event;

  LiveEventShowCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        mainTower(event, 10),
        Image.asset(
          LocalImages().play,
        ),
      ],
    );
  }
}
