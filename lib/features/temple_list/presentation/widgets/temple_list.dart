// ignore_for_file: dead_code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/worship.dart';

import '../../domain/entities/temple_list_response.dart';
import '../bloc/temple_list/temple_list_bloc.dart';
import '../bloc/temple_list/temple_list_state.dart';
import '../bloc/worship/worship_bloc.dart';
import '../pages/temple_list.dart';
import '/config/common/extensions.dart';
import '/config/common/widgets/text_widgets.dart';
import '/config/constants.dart';
import 'search_bar.dart';
import 'temple_tile.dart';

ValueNotifier<List<TempleListResponseEntity>>? _templeListNotifier;
ValueNotifier<int> godSelected = ValueNotifier(-1);
alltempleListBlocBuilder() {
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
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is TempleListLoaded) {
        dynamic templeList = state.templeList!;
        List<TempleListResponseEntity> loadedList =
            state.templeList as List<TempleListResponseEntity>;
        _templeListNotifier = ValueNotifier(loadedList);
        return allTempleListPageView(context, templeList, state);
      }
      return const SizedBox();
    },
  );
}

allTempleListPageView(
    BuildContext context, loadedTempleList, TempleListLoaded state) {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: ValueListenableBuilder<List<TempleListResponseEntity>>(
        valueListenable: _templeListNotifier!,
        builder: (context, templeList, child) {
          return ValueListenableBuilder<bool>(
              valueListenable: showFilterWidget,
              builder: (context, showFilter, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: godSelected.value == -1,
                      child: Row(
                        children: [
                          Flexible(
                            child: searchWidget(context, searchFieldController,
                                _templeListNotifier, loadedTempleList),
                          ),
                          Visibility(
                            visible: searchFieldController.text.isEmpty,
                            child: IconButton(
                              onPressed: () {
                                showFilterWidget.value =
                                    !showFilterWidget.value;
                              },
                              icon: Icon(
                                Icons.filter_list_rounded,
                                color: showFilter
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    godSelected.value == -1 ? 16.ph : 0.ph,
                    Visibility(
                      visible: searchFieldController.text.isEmpty && showFilter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildHeading(context, "categories",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Visibility(
                              visible: godSelected.value != -1,
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    godSelected.value = -1;
                                    _templeListNotifier!.value =
                                        loadedTempleList;
                                  },
                                  child: Text(
                                    "clear",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible:
                            searchFieldController.text.isEmpty && showFilter,
                        child: _godCategories(state)),
                    _buildHeadingTextwithValue(templeList, context),
                    _allTempleListView(templeList, state),
                  ],
                );
              });
        }),
  );
}

_buildHeadingTextwithValue(templeList, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(_templeListNotifier!.value.length.toString()),
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
    itemCount: templeList.length,
  );
}

_godCategories(TempleListLoaded templeLoadedstate) {
  List<TempleListResponseEntity> templeList =
      templeLoadedstate.templeList as List<TempleListResponseEntity>;
  return BlocBuilder<WorshipBloc, WorshipState>(
    builder: (context, state) {
      if (state is WorshipLoaded) {
        List<WorshipEntity> godList = state.worship as List<WorshipEntity>;
        return ValueListenableBuilder(
            valueListenable: godSelected,
            builder: (context, isSelected, child) {
              return SizedBox(
                height: 75,
                child: ListView.builder(
                  itemCount: godList.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                        showCheckmark: false,
                        label: Text(godList[index].worshipDesc!),
                        selected: index == isSelected,
                        onSelected: (value) {
                          godSelected.value = index;
                          List<TempleListResponseEntity> filteredTemples =
                              templeList
                                  .where((item) =>
                                      (item.worshipCode ?? 0) ==
                                      (godList[index].worshipCode))
                                  .toList();
                          _templeListNotifier!.value = filteredTemples;
                        },
                      ),
                    );
                  },
                ),
              );
            });
      }

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
          ),
        ),
      );
    },
  );
}

_onTemplePressed(BuildContext context, TempleListResponseEntity article) {
  Navigator.pushNamed(context, '/TempleDetails', arguments: article);
}
