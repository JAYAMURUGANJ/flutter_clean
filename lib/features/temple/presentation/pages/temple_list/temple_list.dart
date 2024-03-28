import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/itms_response.dart';

import '../../bloc/itms/itms_bloc.dart';
import '../../bloc/itms/itms_state.dart';
import '../../widgets/temple_tile.dart';

class TempleList extends StatelessWidget {
  const TempleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(backgroundColor: Colors.green, items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.temple_hindu_outlined), label: "Temples"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: "Booking"),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.settings_outlined), label: "Settings"),
        ]),
      ),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'HR&CE Temples',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _buildBody() {
    return BlocConsumer<ITMSBloc, ITMSState>(
      listener: (context, state) {
        if (state is TempleListLodingError) {
          Navigator.pushNamed(context, '/DioException',
              arguments: state.error!);
        }
        if (state is TempleListLoadingSomthingWentWrong) {
          Navigator.pushNamed(context, '/SomthingWentWrong',
              arguments: state.responseStatus!);
        }
      },
      builder: (context, state) {
        if (state is TempleListLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is TempleListLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TempleListTile(
                temple: state.templeList![index],
                onTemplePressed: (article) =>
                    _onTemplePressed(context, article),
              );
            },
            itemCount: state.templeList!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onTemplePressed(BuildContext context, ItmsResponseEntity article) {
    Navigator.pushNamed(context, '/TempleDetails', arguments: article);
  }
}
