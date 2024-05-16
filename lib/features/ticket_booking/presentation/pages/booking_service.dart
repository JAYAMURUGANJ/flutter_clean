import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../dashboard/presentation/widgets/service_list.dart';
import '/config/common/widgets/app_header.dart';
import '/config/common/widgets/cloud_arc.dart';
import '/config/common/widgets/navigation_drawer.dart';
import '/config/constants.dart';

class BookingServicePage extends StatefulWidget {
  const BookingServicePage({Key? key}) : super(key: key);

  @override
  State<BookingServicePage> createState() => _BookingServicePageState();
}

class _BookingServicePageState extends State<BookingServicePage> {
  @override
  Widget build(BuildContext context) {
    dynamic theme = Theme.of(context);
    return Scaffold(
      appBar: appHeader(
        context: context,
        body: LocaleText("booking", style: appbarTextStyleLarge(theme)),
        trailing: IconButton(
          onPressed: () => buildNavigationDrawer(context),
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
            child: buildTempleServicesList(
                listType: 'GRID', services: bookingServicesList),
          ),
        ],
      ),
    );
  }
}
