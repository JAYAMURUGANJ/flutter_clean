// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/features/dashboard/presentation/widgets/live_events.dart';

import '../../../../config/common/widgets/bottom_sheet.dart';
import '../../../../config/common/widgets/text_widgets.dart';
import '../../../temple_details/presentation/widgets/main_tower.dart';
import '/config/constants.dart';
import '/features/dashboard/domain/entities/live_events.dart';
import '/features/dashboard/presentation/bloc/live_events/live_events_bloc.dart';

class WhatsNewIndicatior extends StatefulWidget {
  const WhatsNewIndicatior({Key? key}) : super(key: key);

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
          return const CupertinoActivityIndicator();
        }
        if (state is LiveEventsLoadingSomthingWentWrong) {
          return Text(state.responseStatus ?? "no data");
        }
        if (state is LiveEventsLoaded) {
          List<LiveEventsEntity>? liveEvents = state.liveEvents!
              .cast<LiveEventsEntity>()
              .where(
                (element) => element.scrollData!.any((data) =>
                        data.liveurl == "Y" &&
                        data.publishedUpto!.isAfter(DateTime.now())
                    // && data.publishedUpto!.isAtSameMomentAs(DateTime.now()),
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
                            return Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: _buildCard(
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

  _buildCard(LiveEventsEntity liveEvents) => GestureDetector(
      onTap: () => buildBottomSheet(
            context,
            liveEvents,
            'live_events',
            SizedBox(
              height: double.infinity,
              child: LiveEventsWidget(liveEvents),
            ),
          ),
      child: mainTower(liveEvents, 10));
}
