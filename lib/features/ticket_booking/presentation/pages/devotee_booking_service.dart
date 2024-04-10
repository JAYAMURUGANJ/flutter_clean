import 'package:flutter/material.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/cloud_arc.dart';
import '../../../dashboard/presentation/widgets/service_list.dart';

class DevoteeBookingService extends StatefulWidget {
  const DevoteeBookingService({Key? key}) : super(key: key);

  @override
  State<DevoteeBookingService> createState() => _DevoteeBookingServiceState();
}

class _DevoteeBookingServiceState extends State<DevoteeBookingService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appHeader(
          context: context,
          body: Text('Devotee Service',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 180),
                painter: CloudArcPainter(
                    themeColor: Theme.of(context).colorScheme.primary),
              ),
            ),
            Center(
              child: buildDevoteeServicesList(listType: 'GRID'),
            ),
          ],
        ));
  }
}
