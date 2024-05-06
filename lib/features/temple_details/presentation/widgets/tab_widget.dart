import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/config/constants.dart';
import 'temple_info.dart';
import 'temple_pooja.dart';
import 'temple_timing.dart';

List<Widget> tabs = const [
  Tab(child: LocaleText("details", textAlign: TextAlign.center)),
  Tab(child: LocaleText("timing", textAlign: TextAlign.center)),
  Tab(child: LocaleText("poojas", textAlign: TextAlign.center)),
];

buildTabBar(BuildContext context, TabController tabController) {
  return Padding(
    padding: defaultPadding,
    child: TabBar(
      controller: tabController,
      isScrollable: true,
      labelColor: Theme.of(context).colorScheme.primary,
      indicatorColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.start,
      labelStyle: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(fontWeight: FontWeight.bold),
      tabs: tabs,
    ),
  );
}

buildTabView(BuildContext context, TabController tabController) {
  return Padding(
    padding: defaultPadding,
    child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          SingleChildScrollView(child: TempleInfoWidget()),
          SingleChildScrollView(child: TempleTiming()),
          SingleChildScrollView(child: TemplePooja()),
        ]),
  );
}
