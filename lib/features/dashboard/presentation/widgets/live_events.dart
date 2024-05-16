import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/config/common/extensions.dart';
import '/features/dashboard/domain/entities/live_events.dart';

class LiveEventsWidget extends StatefulWidget {
  final LiveEventsEntity liveEvents;
  const LiveEventsWidget(this.liveEvents, {Key? key}) : super(key: key);

  @override
  State<LiveEventsWidget> createState() => _LiveEventsWidgetState();
}

class _LiveEventsWidgetState extends State<LiveEventsWidget> {
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
    LiveEventsEntity templeLiveEvents = widget.liveEvents;
    List<ScrollDatum> scrollData = templeLiveEvents.scrollData!;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.white,
                Theme.of(context).colorScheme.primary.blend(Colors.white),
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
          height: MediaQuery.sizeOf(context).height / 3,
        ),
        Column(
          children: [
            buildTempleName(templeLiveEvents, context),
            Visibility(
              visible: scrollData.isNotEmpty,
              child: Expanded(
                child: ListView.builder(
                  itemCount: scrollData.length,
                  itemBuilder: (context, i) {
                    String videoId =
                        youtubeLiveUrl(scrollData[i].eventUrl.toString()) ?? "";
                    debugPrint(videoId);
                    final controller = YoutubePlayerController(
                      initialVideoId: videoId,
                      flags: const YoutubePlayerFlags(autoPlay: false),
                    );

                    return Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: Card(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Visibility(
                                visible: scrollData[i].eventUrl!.isNotEmpty,
                                child: YoutubePlayer(
                                  controller: controller,
                                ),
                              ),
                              5.ph,
                              Text(
                                scrollData[i].eventDesc.toString(),
                                maxLines: 2,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                scrollData[i].liveurlType!.toString(),
                                maxLines: 2,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
      ],
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
              color: Colors.white,
            ),
      ),
    );
  }
}

String? _getYoutubeVideoIdByURL(String url) {
  final regex = RegExp(
      r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?',
      caseSensitive: false);

  try {
    if (regex.hasMatch(url)) {
      return regex.firstMatch(url)!.group(1);
    }
  } catch (e) {
    return '';
  }
  return null;
}

String? youtubeLiveUrl(String url) {
  if (_getYoutubeVideoIdByURL(url) == null) {
    return null;
  } else {
    var parts = url.split('/');
    var prefix = parts[3];
    if (prefix == 'live') {
      return parts[4];
    } else {
      return '';
    }
  }
}

String? youtubeImageUrl(String url) {
  if (_getYoutubeVideoIdByURL(url) == null) {
    return null;
  } else {
    return YoutubePlayer.convertUrlToId(url)!;
  }
}
