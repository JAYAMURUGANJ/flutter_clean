// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

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

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

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
      body: _buildBody(context),
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
              builder: ((context) => ValueListenableBuilder(
                  valueListenable: selectedIndex,
                  builder: ((context, value, child) => AlertDialog.adaptive(
                        title: LocaleText(
                          'select_distance',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        content: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          runAlignment: WrapAlignment.spaceBetween,
                          children: List.generate(
                            distanceList.length,
                            (index) => ChoiceChip(
                              showCheckmark: false,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.green.shade900, width: 2.0),
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
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
                                    fontWeight: FontWeight.bold),
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
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: LocaleText(
                                  "n",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent.shade400),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  pageNavigation(state.page.toString(), context,
                                      arguments: LocationInfo(
                                        fromCurrent: true,
                                        currentLocation: state.locationData,
                                        distance:
                                            distanceList[selectedIndex.value],
                                      ));
                                },
                                child: LocaleText(
                                  "y",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent.shade400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))));
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
