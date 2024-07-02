import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app_clean_architecture/config/constants.dart';
import 'package:shimmer/shimmer.dart';

import '/config/common/extensions.dart';
import '/config/common/pages/error/something_went_wrong_screen.dart';
import '/features/settings/presentation/bloc/selected_favorite_temples/selected_favorite_temples_cubit.dart';
import '../../../../config/common/class/local_language_controller.dart';
import '../../../temple_list/domain/entities/worship_god_list.dart';
import '../../../temple_list/presentation/bloc/worship_god_list/worship_god_list_bloc.dart';

class FavoriteTemplesWidget extends StatefulWidget {
  const FavoriteTemplesWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteTemplesWidget> createState() => _FavoriteTemplesWidgetState();
}

class _FavoriteTemplesWidgetState extends State<FavoriteTemplesWidget> {
  List<int> selectedTemples = [];
  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController =
        Get.find<LocalizationController>();
    return BlocConsumer<WorshipGodListBloc, WorshipGodListState>(
      listener: (context, state) {
        if (state is WorshipLoadingError) {
          Navigator.pushNamed(context, '/DioException',
              arguments: state.error!);
        }
      },
      builder: (context, state) {
        if (state is WorshipLoadingSomthingWentWrong) {
          return Center(
            child: SizedBox(
              height: 300,
              child: SomethingWentWrong(
                error: state.responseStatus!,
                errorIcon: LocalImages().noDataAvailable,
              ),
            ),
          );
        }

        if (state is WorshipLoading) {
          return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Center(
                child: Column(
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
                        itemCount: 30,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                BlocProvider.of<SelectedFavoriteTemplesCubit>(
                                        context)
                                    .onSelectFavorites(selectedTemples, index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(LocalImages().logo,
                                          height: 120),
                                    ),
                                    const Flexible(
                                      child: Text(
                                        "NAME",
                                        style: TextStyle(
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
                ),
              ));
        }

        return BlocBuilder<WorshipGodListBloc, WorshipGodListState>(
          builder: (context, state) {
            if (state is WorshipLoaded) {
              List<WorshipGodEntity> godList =
                  state.worship as List<WorshipGodEntity>;
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
                                      .onSelectFavorites(
                                          selectedTemples, index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color:
                                        (selectionState is FavoritesSelected &&
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(LocalImages().tnLogo,
                                            height: 120),
                                      ),
                                      Flexible(
                                        child: Text(
                                          localizationController
                                                      .currentLanguage ==
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
      },
    );
  }
}
