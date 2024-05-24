// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:wakelock/wakelock.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../config/common/widgets/no_data_available.dart';
import '../../../../config/constants.dart';
import '../../../temple_details/presentation/widgets/main_tower.dart';
import '/features/dashboard/domain/entities/live_events.dart';

class TempleLiveStreams extends StatefulWidget {
  final List<LiveEventsEntity> liveEvents;
  final bool isUtchavarDarshan;
  const TempleLiveStreams({
    Key? key,
    required this.liveEvents,
    required this.isUtchavarDarshan,
  }) : super(key: key);

  @override
  State<TempleLiveStreams> createState() => _TempleLiveStreamsState();
}

class _TempleLiveStreamsState extends State<TempleLiveStreams> {
  String? videoId;
  dynamic controller = YoutubePlayerController(
    initialVideoId: "",
    flags: const YoutubePlayerFlags(
      mute: false,
      autoPlay: false,
      disableDragSeek: false,
      loop: false,
      isLive: true,
      forceHD: true,
      enableCaption: true,
    ),
  );
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
        ? SingleChildScrollView(child: _LiveStreamTempleListBuilder())
        : DataNotAvailable(
            error: "live_telecasting_not_available",
            img: NetworkImages.noLiveAvailable);
  }

  Widget _LiveStreamTempleListBuilder() {
    return ExpansionPanelList.radio(
      elevation: 3,
      dividerColor: Colors.grey,
      children: widget.liveEvents
          .map<ExpansionPanelRadio>((LiveEventsEntity liveEvent) {
        return ExpansionPanelRadio(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) =>
              _ExpansionHeader(liveEvent, context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _ExpansionBody(liveEvent),
          ),
          value: liveEvent.templeId.toString(),
        );
      }).toList(),
    );
  }

  SingleChildScrollView _ExpansionBody(LiveEventsEntity liveEvent) {
    var videoId = "";
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
        expansionCallback: (panelIndex, isExpanded) async {
          videoId =
              await getLiveVideoId(liveEvent.scrollData![panelIndex].eventUrl!);
          controller = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              disableDragSeek: false,
              loop: false,
              isLive: true,
              forceHD: true,
              enableCaption: true,
            ),
          );
        },
        elevation: 3,
        dividerColor: Colors.grey,
        children: liveEvent.scrollData!
            .cast<ScrollDatum>()
            .where((element) =>
                element.liveurlType == "U" && element.liveurl == "Y")
            .toList()
            .map<ExpansionPanelRadio>((ScrollDatum scrollData) {
          return ExpansionPanelRadio(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                leading: Image.asset(
                  LocalImages().play,
                ),
                title: Text(scrollData.eventDesc.toString()),
              );
            },
            body: Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: YoutubePlayer(
                  controller: controller,
                ),
              ),
            ),
            value: "${scrollData.eventUrl}${scrollData.eventDesc}",
          );
        }).toList(),
      ),
    );
  }

  ListTile _ExpansionHeader(LiveEventsEntity liveEvent, BuildContext context) {
    return ListTile(
      leading: mainTower(liveEvent, 30),
      title: Text(
        Locales.lang == "en"
            ? liveEvent.templeName.toString()
            : liveEvent.ttempleName.toString(),
        softWrap: true,
        textAlign: TextAlign.left,
        maxLines: 3,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
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
  debugPrint(url.toString());

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
    debugPrint('Error: $e');
  }
  return "null";
}
