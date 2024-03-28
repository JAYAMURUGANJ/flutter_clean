import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/constants.dart';
import '../../../domain/entities/itms_response.dart';
import '../../bloc/itms/itms_bloc.dart';
import '../../bloc/itms/itms_event.dart';
import '../../bloc/itms/itms_state.dart';
import '../../widgets/temple_tile.dart';

TextEditingController _searchFieldController = TextEditingController();

class TempleList extends StatelessWidget {
  const TempleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.temple_hindu_outlined), label: "Temples"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined), label: "Booking"),
        // BottomNavigationBarItem(
        //     icon: Icon(Icons.person_outline_rounded), label: "Profile"),
      ]),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'HRCE',
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
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 28),
                  child: Text(
                    "Temples",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        color: Colors.black.withOpacity(0.8)),
                  ),
                ),
                _searchWidget(context),
                _categoriesWidget(),
                // temple list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: TempleListTile(
                        temple: state.templeList![index],
                        onTemplePressed: (article) =>
                            _onTemplePressed(context, article),
                      ),
                    );
                  },
                  itemCount: state.templeList!.length,
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Padding _categoriesWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 130,
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 12, bottom: 8, right: 8),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemExtent: 110,
            itemCount: godList.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(8),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                      image: DecorationImage(
                          image: AssetImage(godList[index].imageLink!)),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)]
                          .shade600,
                      borderRadius: BorderRadius.circular(16)),
                  //child: Image.asset(godList[index].imageLink!),
                ))),
      ),
    );
  }

  TextField _searchWidget(BuildContext context) {
    return TextField(
      controller: _searchFieldController,
      onChanged: (value) {
        BlocProvider.of<ITMSBloc>(context).add(FilterTempleList(value));
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      maxLines: 1,
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        fillColor: Colors.grey.withOpacity(0.2),
        filled: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
            borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(0),
        suffixIcon: IconButton(
            onPressed: () {
              _searchFieldController.clear();
              BlocProvider.of<ITMSBloc>(context).add(FilterTempleList(""));
            },
            icon: const Icon(
              Icons.clear_rounded,
              color: Colors.grey,
            )),
      ),
    );
  }

  void _onTemplePressed(BuildContext context, ItmsResponseEntity article) {
    Navigator.pushNamed(context, '/TempleDetails', arguments: article);
  }
}
