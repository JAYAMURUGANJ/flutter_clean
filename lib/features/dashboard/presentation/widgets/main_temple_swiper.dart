import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../../../config/common/widgets/text_widgets.dart';
import '../../../../config/constants.dart';
import '../../../temple_list/domain/entities/itms_response.dart';
import '../../../temple_list/presentation/bloc/itms/itms_bloc.dart';
import '../../../temple_list/presentation/bloc/itms/itms_state.dart';
import '../../../temple_list/presentation/widgets/temple_tile.dart';

mainTempleListBlocBuilder() {
  final CardSwiperController controller = CardSwiperController();
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
            height: 300, child: Center(child: CupertinoActivityIndicator()));
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
                    child: buildHeading(context, "main_temples"),
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

mainTempleListView(BuildContext context, templeList, TempleListLoaded state,
    CardSwiperController controller) {
  return SizedBox(
    width: double.infinity,
    height: 440,
    child: CardSwiper(
      controller: controller,
      backCardOffset: const Offset(0, 40),
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
  debugPrint(
    'The card $currentIndex was undod from the ${direction.name}',
  );
  return true;
}

bool onSwipe(
  int previousIndex,
  int? currentIndex,
  CardSwiperDirection direction,
) {
  debugPrint(
    'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
  );
  return true;
}

onTemplePressed(BuildContext context, ItmsResponseEntity article) {
  Navigator.pushNamed(context, '/TempleDetails', arguments: article);
}
