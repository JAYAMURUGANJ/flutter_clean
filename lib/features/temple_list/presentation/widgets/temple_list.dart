import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_locales/flutter_locales.dart';

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

mainTempleListBlocBuilder() {
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
        return const SizedBox(
            height: 200, child: Center(child: CupertinoActivityIndicator()));
      }

      if (state is TempleListLoaded) {
        dynamic templeList = state.templeList!;
        return Padding(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LocaleText(
                "main_temples",
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              mainTempleListView(context, templeList, state),
            ],
          ),
        );
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
        buildHeadingText(context, "categories"),
        _godCategories(),
        buildHeadingText(context, "temples"),
        allTempleListView(templeList, state),
      ],
    ),
  );
}

mainTempleListView(BuildContext context, templeList, TempleListLoaded state) {
  return SizedBox(
    height: 320,
    child: CardSwiper(
      backCardOffset: const Offset(0, 24),
      numberOfCardsDisplayed: 3,
      cardsCount: templeList.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          MainTempleListTile(
        temple: templeList[index],
        onTemplePressed: (article) => _onTemplePressed(context, article),
      ),
    ),
  );
}

allTempleListView(templeList, TempleListLoaded state) {
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
