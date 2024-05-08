import 'package:dio/dio.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/config/common/widgets/no_data_available.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '/features/dashboard/domain/entities/live_events.dart';

class LiveEventsWidget extends StatefulWidget {
  final LiveEventsEntity liveEvents;
  const LiveEventsWidget(this.liveEvents, {Key? key}) : super(key: key);

  @override
  State<LiveEventsWidget> createState() => _LiveEventsWidgetState();
}

class _LiveEventsWidgetState extends State<LiveEventsWidget> {
  //https://i.ytimg.com/vi/NBbQ0A03l4w/mqdefault_live.jpg
  //https://www.youtube.com/watch?v=NBbQ0A03l4w

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
    List<ScrollDatum> scrollData = templeLiveEvents.scrollData!
        .cast<ScrollDatum>()
        .where((data) =>
            data.liveurl == "Y" && data.publishedUpto!.isAfter(DateTime.now()))
        .toList();

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
            scrollData.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: scrollData.length,
                      itemBuilder: (context, i) {
                        return FutureBuilder(
                            future: compute(
                                getLiveVideoId, scrollData[i].eventUrl!),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> videoId) {
                              debugPrint(videoId.data);
                              final controller = YoutubePlayerController(
                                initialVideoId: videoId.data ?? "",
                                flags:
                                    const YoutubePlayerFlags(autoPlay: false),
                              );
                              if (videoId.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
                                  child: Card(
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else if (videoId.hasError) {
                                return noDataAvailable(
                                    context, "No Live Video found.");
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Card(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 220,
                                      child: Center(
                                        child: Text(
                                          "Loading...",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            });
                      },
                    ),
                  )
                : noDataAvailable(context, "Data is not available"),
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

Future<String> getLiveVideoId(String eventUrl) async {
  var dio = Dio();
  debugPrint(eventUrl);
  String urls = 'https://www.youtube.com/channel/UCPP3etACgdUWvizcES1dJ8Q/live';
  RegExp regExp = RegExp(r"(?<=channel\/)(.*?)(?=\/live)");
  String channelId = regExp.firstMatch(urls)?.group(0) ?? '';
  var url = 'https://www.googleapis.com/youtube/v3/search'
      '?part=snippet'
      '&channelId=$channelId'
      '&eventType=live'
      '&type=video'
      '&key=AIzaSyAe-8b7JH3eiu2UrfxwKFGjofRqeGfnR3g';

  try {
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      var items = jsonResponse['items'];
      if (items.length > 0) {
        return items[0]['id']['videoId'];
      }
    }
  } catch (e) {
    print('Error: $e');
  }
  return "null";
}
