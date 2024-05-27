// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../temple_details/presentation/widgets/main_tower.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/no_data_available.dart';
import '/config/constants.dart';
import '/features/dashboard/domain/entities/live_events.dart';

class TempleLiveStreams extends StatefulWidget {
  final List<LiveEventsEntity> liveEvents;
  final String liveurlType;
  final String liveurl;
  const TempleLiveStreams({
    Key? key,
    required this.liveEvents,
    required this.liveurlType,
    required this.liveurl,
  }) : super(key: key);

  @override
  State<TempleLiveStreams> createState() => _TempleLiveStreamsState();
}

class _TempleLiveStreamsState extends State<TempleLiveStreams> {
  String? videoId;
  dynamic controller;
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    super.dispose();
    WakelockPlus.disable();
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
      expandIconColor: Theme.of(context).colorScheme.primary,
      children: widget.liveEvents.map<ExpansionPanelRadio>(
        (LiveEventsEntity liveEvent) {
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
        },
      ).toList(),
    );
  }

  Widget _ExpansionBody(LiveEventsEntity liveEvent) {
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
        elevation: 3,
        dividerColor: Colors.grey,
        children: liveEvent.scrollData!
            .map<ExpansionPanelRadio>((ScrollDatum scrollData) {
          controller = YoutubePlayerController(
            initialVideoId: scrollData.eventUrl!.youtubeLiveUrl ?? "",
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
          return ExpansionPanelRadio(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                leading: Image.asset(
                  LocalImages().play,
                ),
                title: Text(
                  scrollData.eventDesc.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
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

  Widget _ExpansionHeader(LiveEventsEntity liveEvent, BuildContext context) {
    return ListTile(
      leading: mainTower(liveEvent, 30),
      title: Text(
        Locales.lang == "en"
            ? liveEvent.templeName.toString()
            : liveEvent.ttempleName.toString(),
        softWrap: true,
        textAlign: TextAlign.left,
        maxLines: 5,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
