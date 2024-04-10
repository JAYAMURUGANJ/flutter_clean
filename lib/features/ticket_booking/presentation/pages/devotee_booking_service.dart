import 'package:flutter/material.dart';

import '../../../../config/common/widgets/app_header.dart';
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
      body: buildDevoteeServicesList(listType: 'GRID'),
    );
  }
}
