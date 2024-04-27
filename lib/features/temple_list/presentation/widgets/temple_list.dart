// ignore_for_file: dead_code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';

import '../../../../config/common/widgets/text_widgets.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/itms_response.dart';
import '../bloc/itms/itms_bloc.dart';
import '../bloc/itms/itms_state.dart';
import 'temple_tile.dart';

alltempleListBlocBuilder() {
  return BlocConsumer<ITMSBloc, ITMSState>(
    listener: (context, state) {
      if (state is TempleListLodingError) {
        Navigator.pushNamed(context, '/DioException', arguments: state.error!);
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
        dynamic templeList = state.templeList!;
        return allTempleListPageView(context, templeList, state);
      }
      return const SizedBox();
    },
  );
}

allTempleListPageView(
    BuildContext context, templeList, TempleListLoaded state) {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        5.ph,
        buildHeading(context, "categories"),
        _godCategories(),
        _buildHeadingTextwithValue(templeList, context),
        _allTempleListView(templeList, state),
      ],
    ),
  );
}

_buildHeadingTextwithValue(templeList, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(templeList.length.toString()),
        ),
      ),
      buildHeading(context, "temples"),
    ],
  );
}

_allTempleListView(templeList, TempleListLoaded state) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemExtent: 100,
    itemBuilder: (context, index) {
      return TempleListTile(
        temple: templeList[index],
        onTemplePressed: (article) => _onTemplePressed(context, article),
      );
    },
    itemCount: state.templeList!.length,
  );
}

_godCategories() {
  return SizedBox(
    height: 90,
    child: ListView.builder(
      // padding: const EdgeInsets.only(right: 2),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemExtent: 80,
      itemCount: godList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: godList[index].bgColor,
            image:
                DecorationImage(image: AssetImage(godList[index].imageLink!)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_onTemplePressed(BuildContext context, ItmsResponseEntity article) {
  Navigator.pushNamed(context, '/TempleDetails', arguments: article);
}
