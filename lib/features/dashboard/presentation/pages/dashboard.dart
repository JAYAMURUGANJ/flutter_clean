import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../widgets/service_list.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText(
          "thirukoil",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w800),
        ),
        //  centerTitle: false,
      ),
      body: _buildBody(context),
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
          buildServicesList()
        ],
      ),
    );
  }
}
