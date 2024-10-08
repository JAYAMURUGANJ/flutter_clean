import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/network_aware.dart';
import '../../../dashboard/presentation/pages/dashboard.dart';
import '../../../settings/presentation/pages/settings.dart';
import '../../../temple_list/presentation/pages/temple_list.dart';
import '../../../ticket_booking/presentation/pages/booking_service.dart';
import '../bloc/bottom_navigation/bottom_navigation_cubit.dart';

List<Widget> _pages = [
  const Dashboard(),
  const TempleListPage(),
  const BookingServicePage(),
  const Settings(),
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NetworkAware(
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final NavigatorState navigator = Navigator.of(context);
          final bool? shouldPop = await _showDialog(context);
          if (shouldPop ?? false) {
            navigator.pop();
          }
        },
        child: Scaffold(
          body: _buildBody(),
          bottomNavigationBar: _buildBottomBar(),
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, index) {
        return _pages[index];
      },
    );
  }

  _buildBottomBar() {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, selectedIndex) {
        return BottomNavigationBar(
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (value) {
              BlocProvider.of<BottomNavigationCubit>(context).changePage(value);
            },
            items: [
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.home_filled),
                  icon: const Icon(Icons.home_outlined),
                  label: Locales.lang == "en" ? "Home" : "முகப்பு"),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.temple_hindu),
                  icon: const Icon(Icons.temple_hindu_outlined),
                  label: Locales.lang == "en" ? "Temple" : "கோவில்"),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.calendar_month),
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: Locales.lang == "en" ? "Booking" : "முன்பதிவு"),
              BottomNavigationBarItem(
                  activeIcon: const Icon(Icons.settings_applications),
                  icon: const Icon(Icons.settings),
                  label: Locales.lang == "en" ? "Setting" : "அமைப்பு"),
            ]);
      },
    );
  }

  Future<bool?> _showDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: buildDialogReason(context, "app_close"),
          actions: buildDialogAction(context),
        );
      },
    );
  }

  Text buildDialogReason(BuildContext context, String reason,
      {bool isLocalReason = true}) {
    return isLocalReason
        ? LocaleText(
            reason,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          )
        : Text(
            reason,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          );
  }

  List<Widget> buildDialogAction(BuildContext context,
      {bool isActionRequired = true}) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: LocaleText(
              "n",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.redAccent.shade400),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: LocaleText(
              "y",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.blueAccent.shade400),
            ),
          ),
        ],
      )
    ];
  }
}
