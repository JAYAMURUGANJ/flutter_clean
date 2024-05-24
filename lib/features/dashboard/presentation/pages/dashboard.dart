// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/app_header.dart';
import '../../../../config/common/widgets/app_refer_card.dart';
import '../../../../config/common/widgets/navigation_drawer.dart';
import '../../../../config/constants.dart';
import '../widgets/dashboard_live.dart';
import '../bloc/current_location/current_location_bloc.dart';
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
    ValueNotifier<int> _selectedIndex = ValueNotifier(0);
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, state) {
        if (state is CurrentLocationLoading) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Row(
              children: [
                CupertinoActivityIndicator(
                  color: Colors.white,
                ),
                Text("fetching current location...")
              ],
            ),
            duration: Duration(minutes: 2),
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
                  valueListenable: _selectedIndex,
                  builder: ((context, value, child) => AlertDialog.adaptive(
                        title: const LocaleText('select_distance'),
                        content: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          runAlignment: WrapAlignment.spaceBetween,
                          children: List.generate(
                            distanceList.length,
                            (index) => ChoiceChip(
                              showCheckmark: false,
                              label:
                                  Text(distanceList[index].round().toString()),
                              selected: _selectedIndex.value == index,
                              onSelected: (value) {
                                _selectedIndex.value = index;
                                print(distanceList[index]);
                              },
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('cancel')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                pageNavigation(state.page.toString(), context,
                                    arguments: {
                                      "current_location": state.locationData,
                                      "distance":
                                          distanceList[_selectedIndex.value]
                                    });
                              },
                              child: const Text('confirm')),
                        ],
                      )))));
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
