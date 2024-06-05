// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/app_refer_card.dart';
import '../../../../config/common/widgets/navigation_drawer.dart';
import '../../../../config/constants.dart';
import '../../../temple_details/data/model/location_info.dart';
import '../bloc/current_location/current_location_bloc.dart';
import '../widgets/dashboard_live.dart';
import '../widgets/main_temple_swiper.dart';
import '../widgets/service_list.dart';
import '/config/common/extensions.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = true; // New variable to track loading state

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    // Simulate a delay to show the shimmer effect
    Future.delayed(const Duration(microseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appHeader(
        context: context,
        body: LocaleText("thirukoil",
            textAlign: TextAlign.center, style: appbarTextStyleLarge(theme)),
        trailing: IconButton(
          onPressed: () => buildNavigationDrawer(context),
          icon: const Icon(Icons.menu),
        ),
      ),
      body: isLoading ? _dashboardshimmerEffect() : _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          5.ph,
          DashboardLive(
            liveurl: "Y",
            liveurlType: "C",
          ),
          buildDevoteeServiceList(context),
          mainTempleListBlocBuilder(),
          otherServiceList(context),
          15.ph,
          const AppReferalCard(),
          15.ph,
          _buildCurrentLocationDialog()
        ],
      ),
    );
  }

  BlocListener<CurrentLocationBloc, CurrentLocationState>
      _buildCurrentLocationDialog() {
    ValueNotifier<int> selectedIndex = ValueNotifier(0);
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, state) {
        if (state is CurrentLocationLoading) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CupertinoActivityIndicator(
                  color: Colors.white,
                ),
                5.pw,
                const Flexible(
                  child: LocaleText(
                    "fetch_location",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )
              ],
            ),
            duration: const Duration(minutes: 2),
          ));
        }
        if (state is CurrentLocationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 2),
          ));
        }
        if (state is CurrentLocationSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          showDialog(
            context: context,
            builder: (context) => ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, value, child) => AlertDialog.adaptive(
                title: LocaleText(
                  'select_distance',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                content: Wrap(
                  spacing: 8.0,
                  children: List.generate(
                    distanceList.length,
                    (index) => ChoiceChip(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.green.shade900, width: 2.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      selectedColor: selectedIndex.value == index
                          ? Colors.green
                          : Colors.transparent,
                      label: Text(
                        "${distanceList[index].round().toString()} KM",
                        style: TextStyle(
                          fontSize: 15,
                          color: selectedIndex.value == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: selectedIndex.value == index,
                      onSelected: (value) {
                        selectedIndex.value = index;
                      },
                    ),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: LocaleText(
                          "n",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent.shade400,
                                  ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          pageNavigation(
                            state.page.toString(),
                            context,
                            arguments: LocationInfo(
                              fromCurrent: true,
                              currentLocation: state.locationData,
                              distance: distanceList[selectedIndex.value],
                            ),
                          );
                        },
                        child: LocaleText(
                          "y",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent.shade400,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget _dashboardshimmerEffect() {
    CardSwiperController controller = CardSwiperController();
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: defaultPadding,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                10.ph,
                const Align(
                  alignment: Alignment.topLeft,
                  child: Card(
                    child: SizedBox(
                      width: 80,
                      height: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) => const CircleAvatar(
                      radius: 40,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Card(
                      child: SizedBox(
                        width: 90,
                        height: 10,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                        20.pw,
                        const Icon(
                          Icons.arrow_forward,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: CardSwiper(
                      controller: controller,
                      backCardOffset: const Offset(0, 30),
                      numberOfCardsDisplayed: 3,
                      cardsCount: 10,
                      cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) =>
                          const Card(
                            child: SizedBox(
                              width: 200,
                              height: 180,
                            ),
                          )),
                ),
                20.ph,
                SizedBox(
                  height: 200,
                  child: Wrap(
                    spacing: 25.0,
                    children: List.generate(
                      6,
                      (index) => const Card(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
