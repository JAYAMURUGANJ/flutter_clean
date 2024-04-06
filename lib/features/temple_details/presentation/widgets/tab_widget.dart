import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/features/temple_details/presentation/widgets/temple_info.dart';

buildTabBar(BuildContext context, TabController tabController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
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
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
          tabs: const [
            //  Tab(
            //   child: LocaleText(
            //     "services",
            //     textAlign: TextAlign.center,
            //     //  style: Theme.of(context).textTheme.bodySmall,
            //   ),
            // ),
            Tab(
              child: LocaleText(
                "details",
                textAlign: TextAlign.center,
              ),
            ),
            Tab(
              child: LocaleText(
                "timing",
                textAlign: TextAlign.center,
              ),
            ),
            Tab(
              child: LocaleText(
                "poojas",
                textAlign: TextAlign.center,
              ),
            ),
          ]),
    ),
  );
}

buildTabView(BuildContext context, TabController tabController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
    child: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          // Text("Services",
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          SingleChildScrollView(child: TempleInfoWidget()),
          Text("Timing",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("Pooja",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ]),
  );
}
