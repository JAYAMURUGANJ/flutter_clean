import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/common/widgets/text_widgets.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/itms_response.dart';
import '../bloc/itms/itms_bloc.dart';
import '../bloc/itms/itms_state.dart';
import 'temple_tile.dart';

templeListBuilder() {
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
        return fullTempleListView(context, templeList, state);
      }
      return const SizedBox();
    },
  );
}

mainTempleListBuilder() {
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
        return mainTempleListView(context, templeList, state);
      }
      return const SizedBox();
    },
  );
}

fullTempleListView(BuildContext context, templeList, TempleListLoaded state) {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildHeadingText(context, "categories"),
        _godCategories(),
        buildHeadingText(context, "temples"),
        _templeList(templeList, state),
      ],
    ),
  );
}

mainTempleListView(BuildContext context, templeList, TempleListLoaded state) {
  return SizedBox(
    height: 150,
    child: ListView.builder(
      shrinkWrap: true,
      itemExtent: 140,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return MainTempleListTile(
          temple: templeList[index],
          onTemplePressed: (article) => _onTemplePressed(context, article),
        );
      },
      itemCount: state.templeList!.length,
    ),
  );
}

_templeList(templeList, TempleListLoaded state) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemExtent: 140,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: TempleListTile(
          temple: templeList[index],
          onTemplePressed: (article) => _onTemplePressed(context, article),
        ),
      );
    },
    itemCount: state.templeList!.length,
  );
}

_godCategories() {
  return SizedBox(
    height: 110,
    child: ListView.builder(
      padding: const EdgeInsets.only(right: 3),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemExtent: 100,
      itemCount: godList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(14),
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: godList[index].bgColor,
                image: DecorationImage(
                    image: AssetImage(godList[index].imageLink!)),
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
          ],
        ),
      ),
    ),
  );
}

_onTemplePressed(BuildContext context, ItmsResponseEntity article) {
  Navigator.pushNamed(context, '/TempleDetails', arguments: article);
}
