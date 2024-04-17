// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/app_refer_card.dart';
import '../../../temple_list/presentation/widgets/temple_list.dart';
import '../widgets/service_list.dart';
import '../widgets/whats_new.dart';
import '/config/common/extensions.dart';

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
              style: Theme.of(context).textTheme.titleLarge,
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildWhatsNewList(context),
          buildDevoteeServiceList(context),
          mainTempleListBlocBuilder(),
          otherServiceList(context),
          10.ph,
          const AppReferalCard(),
          10.ph,
        ],
      ),
    );
  }
}
