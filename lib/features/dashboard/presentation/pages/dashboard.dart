// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/cloud_arc.dart';
import '../../../../config/theme/text_theme.g.dart';
import '../../../temple_list/presentation/widgets/temple_list.dart';
import '../widgets/service_list.dart';
import '../widgets/whats_new.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appHeader(
          context: context,
          body: Align(
            alignment: Alignment.topCenter,
            child: LocaleText(
              "thirukoil",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                  foreground: Paint()..shader = linearGradient),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return Stack(
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
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildDevoteeServiceList(context),
              buildWhatsNewList(context),
              mainTempleListBlocBuilder(),
            ],
          ),
        ),
      ],
    );
  }
}
