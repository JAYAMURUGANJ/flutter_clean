import 'package:flutter/material.dart';
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
          labelColor: Theme.of(context).colorScheme.primary,
          indicatorColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          tabs: const [
            Tab(
              child: Text(
                "Details",
                textAlign: TextAlign.center,
              ),
            ),
            Tab(
              text: "Timing",
            ),
            Tab(
              text: "Pooja",
            ),
          ]),
    ),
  );
}

Flexible buildTabView(BuildContext context, TabController tabController) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 18),
      child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TempleInfoWidget(),
            Text("Timing",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text("Pooja",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ]),
    ),
  );
}
