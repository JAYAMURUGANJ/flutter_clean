// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/text_widgets.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/bottom_sheet.dart';
import '/config/constants.dart';
import '/features/dashboard/domain/entities/live_events.dart';
import '/features/dashboard/presentation/bloc/live_events/live_events_bloc.dart';
import '/features/dashboard/presentation/widgets/live_events.dart';

class WhatsNewIndicatior extends StatefulWidget {
  const WhatsNewIndicatior({Key? key}) : super(key: key);

  @override
  _WhatsNewIndicatiorState createState() => _WhatsNewIndicatiorState();
}

class _WhatsNewIndicatiorState extends State<WhatsNewIndicatior> {
  int _currentIndex = 0;
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
          return const CupertinoActivityIndicator();
        }
        if (state is LiveEventsLoadingSomthingWentWrong) {
          return Text(state.responseStatus ?? "no data");
        }
        if (state is LiveEventsLoaded) {
          // print(state.liveEvents!.length);
          List<LiveEventsEntity>? liveEvents = state.liveEvents!
              .cast<LiveEventsEntity>()
              .where(
                (element) => element.scrollData!.any(
                  (data) =>
                      data.liveurl == "Y" &&
                      data.publishedUpto!.isBefore(DateTime.now()) &&
                      data.publishedUpto!.isAtSameMomentAs(DateTime.now()),
                ),
              )
              .toList();
          return Visibility(
            visible: liveEvents.isNotEmpty,
            child: Padding(
              padding: defaultPadding,
              child: SizedBox(
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeading(context, "whats_new"),
                    5.ph,
                    CarouselSlider(
                      items: [for (var item in liveEvents) _buildCard(item)],
                      options: CarouselOptions(
                        height: 110.0,
                        viewportFraction: 0.8,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        liveEvents.length, // Number of cards
                        (index) => _buildIndicator(index, Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCard(LiveEventsEntity liveEvents) {
    return GestureDetector(
      onTap: () => buildBottomSheet(
        context,
        liveEvents,
        'live_events',
        SizedBox(
          height: double.infinity,
          child: LiveEventsWidget(liveEvents),
        ),
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: colors[Random().nextInt(4)],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                radius: 35,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  radius: 33,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(liveEvents
                            .maintowerImage!.isNotEmpty
                        ? ApiCredentials().documents +
                            liveEvents.maintowerImage![0].fileLocation
                                .toString()
                        : "https://hrce.tn.gov.in/demoapp/images/temple_div.png"), //NetworkImage
                    radius: 100,
                  ), //CircleAvatar
                ), //CircleAvatar
              ),
            ),
            3.pw, //CircleAvatar
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    liveEvents.scrollData![0].eventDesc ?? "",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Text(
                    (Locales.lang == "en"
                            ? liveEvents.templeName
                            : liveEvents.ttempleName) ??
                        "",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int index, Color color) {
    return Container(
      width: 7.0,
      height: 7.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? color : Colors.grey,
      ),
    );
  }
}
