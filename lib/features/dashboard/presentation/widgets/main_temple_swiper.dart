import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../temple_list/domain/entities/temple_list.dart';
import '../../../temple_list/presentation/bloc/temple_list/temple_list_bloc.dart';
import '../../../temple_list/presentation/bloc/temple_list/temple_list_state.dart';
import '/config/common/widgets/text_widgets.dart';
import '/config/constants.dart';
import 'main_temple_list_tile.dart';

mainTempleListBlocBuilder() {
  final CardSwiperController controller = CardSwiperController();
  return BlocConsumer<TempleListBloc, TempleListState>(
    listener: (context, state) {
      if (state is TempleListLoadingError) {
        Navigator.pushNamed(context, '/DioException', arguments: state.error!);
      }
      if (state is TempleListLoadingSomthingWentWrong) {
        Navigator.pushNamed(context, '/SomthingWentWrong',
            arguments: state.responseStatus!);
      }
    },
    builder: (context, state) {
      if (state is TempleListLoading) {
        return maintempleshimmerEffect(context);
      }

      if (state is TempleListLoaded) {
        dynamic templeList = state.templeList!;
        return Padding(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: buildHeading(context, "main_temples")),
                  ),
                  IconButton(
                    onPressed: () => controller.undo(),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.right),
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 18,
                    ),
                  )
                ],
              ),
              mainTempleListView(context, templeList, state, controller),
            ],
          ),
        );
      }
      return const SizedBox();
    },
  );
}

Widget maintempleshimmerEffect(context) {
  CardSwiperController controller = CardSwiperController();
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: defaultPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Card(
                child: SizedBox(
                  width: 90,
                  height: 10,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  20.pw,
                  const Icon(
                    Icons.arrow_forward,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: CardSwiper(
                controller: controller,
                backCardOffset: const Offset(0, 30),
                numberOfCardsDisplayed: 3,
                cardsCount: 10,
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) =>
                        const Card(
                          child: SizedBox(
                            width: 200,
                            height: 180,
                          ),
                        )),
          ),
          20.ph,
        ],
      ),
    ),
  );
}

mainTempleListView(BuildContext context, templeList, TempleListLoaded state,
    CardSwiperController controller) {
  return SizedBox(
    width: double.infinity,
    height: 350,
    child: CardSwiper(
      controller: controller,
      backCardOffset: const Offset(0, 30),
      numberOfCardsDisplayed: 3,
      cardsCount: templeList.length,
      onSwipe: onSwipe,
      onUndo: onUndo,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          MainTempleListTile(
        temple: templeList[index],
        onTemplePressed: (article) => onTemplePressed(context, article),
      ),
    ),
  );
}

bool onUndo(
  int? previousIndex,
  int currentIndex,
  CardSwiperDirection direction,
) {
  return true;
}

bool onSwipe(
  int previousIndex,
  int? currentIndex,
  CardSwiperDirection direction,
) {
  return true;
}

onTemplePressed(BuildContext context, TempleListEntity article) {
  Navigator.pushNamed(context, '/TempleDetails', arguments: article);
}
