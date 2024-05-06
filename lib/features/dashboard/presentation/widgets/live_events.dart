import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/features/dashboard/domain/entities/live_events.dart';

class LiveEventsWidget extends StatefulWidget {
  final LiveEventsEntity liveEvents;
  const LiveEventsWidget(this.liveEvents, {Key? key}) : super(key: key);

  @override
  State<LiveEventsWidget> createState() => _LiveEventsWidgetState();
}

class _LiveEventsWidgetState extends State<LiveEventsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            (Locales.lang == "en"
                    ? widget.liveEvents.templeName
                    : widget.liveEvents.ttempleName) ??
                "",
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
