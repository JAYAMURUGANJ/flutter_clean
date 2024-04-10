import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/widgets/app_header.dart';

import '../../../../config/common/widgets/cloud_arc.dart';
import '../../../../config/theme/text_theme.g.dart';
import '../widgets/service_list.dart';

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
            child: _buildBody(context),
          )
        ],
      ),
    );
  }

  _buildBody(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocaleText(
            "devotee_services",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          buildDevoteeServicesList(listType: 'HL')
        ],
      ),
    );
  }
}
