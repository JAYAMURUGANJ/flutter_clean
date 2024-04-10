import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard/presentation/pages/dashboard.dart';
import '../../../settings/presentation/pages/settings.dart';
import '../../../temple_list/presentation/pages/temple_list.dart';
import '../../../ticket_booking/presentation/pages/devotee_booking_service.dart';
import '../bloc/bottom_navigation/bottom_navigation_cubit.dart';

List<Widget> _pages = [
  const Dashboard(),
  const TempleList(),
  const DevoteeBookingService(),
  const Settings(),
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
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
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.temple_hindu_outlined), label: "Temples"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined), label: "Booking"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ]);
      },
    );
  }
}
