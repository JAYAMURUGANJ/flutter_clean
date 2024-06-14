import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/features/settings/presentation/bloc/selected_favorite_temples/selected_favorite_temples_cubit.dart';

import '../../../temple_list/domain/entities/worship.dart';
import '../../../temple_list/presentation/bloc/worship/worship_bloc.dart';
import '../pages/settings.dart';

class FavoriteTemplesWidget extends StatefulWidget {
  const FavoriteTemplesWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteTemplesWidget> createState() => _FavoriteTemplesWidgetState();
}

class _FavoriteTemplesWidgetState extends State<FavoriteTemplesWidget> {
  List<int> selectedTemples = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorshipBloc, WorshipState>(
      builder: (context, state) {
        if (state is WorshipLoaded) {
          List<WorshipEntity> godList = state.worship as List<WorshipEntity>;
          return BlocBuilder<SelectedFavoriteTemplesCubit,
              SelectedFavoriteTemplesState>(
            builder: (context, selectionState) {
              return Column(
                children: [
                  // const LabelText(label: 'favorite_temples'),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 180,
                              crossAxisSpacing: 15,
                              mainAxisExtent: 180,
                              mainAxisSpacing: 15),
                      itemCount: godList.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              BlocProvider.of<SelectedFavoriteTemplesCubit>(
                                      context)
                                  .onSelectFavorites(selectedTemples, index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: (selectionState is FavoritesSelected &&
                                        selectionState.selectedList
                                            .contains(index))
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.2)
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                        "assets/images/logo/tn_logo.png",
                                        // godList[index].imageLink!,
                                        height: 120),
                                  ),
                                  Flexible(
                                    child: Text(
                                      context.currentLocale!.languageCode ==
                                              "ta"
                                          ? godList[index].tworshipDesc!
                                          : godList[index].worshipDesc!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )

                      // Text(indivualTemple[index].name!),
                      )
                ],
              );
            },
          );
        }
        return 0.ph;
      },
    );
  }
}
