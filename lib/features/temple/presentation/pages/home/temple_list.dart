import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/config/common/widgets/app_logo.dart';

import '../../../../../config/constants.dart';
import '../../../domain/entities/itms_response.dart';
import '../../bloc/itms/itms_bloc.dart';
import '../../bloc/itms/itms_state.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/temple_tile.dart';

TextEditingController searchFieldController = TextEditingController();

class TempleList extends StatelessWidget {
  const TempleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                const AppIcon(
                  height: 60,
                ),
                5.pw,
                Expanded(child: searchWidget(context, searchFieldController)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
              ],
            ),
          ),
        ),
      ),
      body: _templeListBuilder(),
      bottomNavigationBar: BottomNavigationBar(items: const [
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

  _templeListBuilder() {
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
                _godCategoriesWidget(),
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

  _godCategoriesWidget() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        padding: const EdgeInsets.only(right: 3),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemExtent: 110,
        itemCount: godList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(5),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(godList[index].imageLink!)),
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  .shade600,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  void _onTemplePressed(BuildContext context, ItmsResponseEntity article) {
    Navigator.pushNamed(context, '/TempleDetails', arguments: article);
  }
}
