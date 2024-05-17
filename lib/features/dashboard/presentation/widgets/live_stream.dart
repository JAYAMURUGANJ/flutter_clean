import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../config/common/widgets/no_data_available.dart';
import '../../../../config/constants.dart';
import '/config/common/extensions.dart';
import '/features/dashboard/domain/entities/live_events.dart';

class TempleLiveStreams extends StatefulWidget {
  final List<LiveEventsEntity> liveEvents;
  const TempleLiveStreams(this.liveEvents, {Key? key}) : super(key: key);

  @override
  State<TempleLiveStreams> createState() => _TempleLiveStreamsState();
}

class _TempleLiveStreamsState extends State<TempleLiveStreams> {
  String? videoId;
  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    return widget.liveEvents.isNotEmpty
        ? ListView.builder(
            itemCount: widget.liveEvents.length,
            itemBuilder: (context, j) {
              List<ScrollDatum> scrollData = widget.liveEvents[j].scrollData!;
              return SizedBox(
                height: 300,
                child: Column(
                  children: [
                    buildTempleName(widget.liveEvents[j], context),
                    Visibility(
                      visible: scrollData.isNotEmpty,
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: scrollData.length,
                          itemBuilder: (context, i) {
                            String videoId =
                                scrollData[i].eventUrl!.youtubeLiveUrl ?? "";
                            final controller = YoutubePlayerController(
                              initialVideoId: videoId,
                              flags: const YoutubePlayerFlags(autoPlay: false),
                            );
                            return Visibility(
                              visible: scrollData[i].eventUrl!.isNotEmpty &&
                                  videoId != "",
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        YoutubePlayer(
                                          controller: controller,
                                        ),
                                        5.ph,
                                        Text(
                                          scrollData[i].eventDesc.toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        : Center(
            child: DataNotAvailable(
                error: "Live Telecasting not available",
                img: NetworkImages.noLiveAvailable),
          );
  }

  List<ScrollDatum> sortLiveScrollData(LiveEventsEntity state) => state
      .scrollData!
      .cast<ScrollDatum>()
      .where((data) =>
          data.liveurl == "Y" && data.publishedUpto!.isAfter(DateTime.now()))
      .toList();

  buildTempleName(LiveEventsEntity liveEventsDetails, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Text(
        Locales.lang == "en"
            ? liveEventsDetails.templeName.toString()
            : liveEventsDetails.ttempleName.toString(),
        softWrap: true,
        textAlign: TextAlign.center,
        maxLines: 3,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
