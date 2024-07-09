import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/features/temple_list/domain/entities/temple_list.dart';

import '../pages/temple_list.dart';

TextField searchWidget(
    BuildContext context,
    searchFieldController,
    ValueNotifier<List<TempleEntity>>? templeListNotifier,
    List<TempleEntity> loadedTempleList) {
  return TextField(
    controller: searchFieldController,
    onChanged: (value) {
      List<TempleEntity> filteredTemples = loadedTempleList
          .where((item) =>
              (item.templeName!.toLowerCase().contains(value.toLowerCase())) ||
              item.ttempleName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      templeListNotifier!.value = filteredTemples;
    },
    onTapOutside: (event) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    maxLines: 1,
    decoration: InputDecoration(
      hintText: "Search Temple Here...",
      prefixIcon: const Icon(Icons.search),
      fillColor: Colors.grey.withOpacity(0.2),
      filled: true,
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.all(0),
      suffixIcon: IconButton(
        onPressed: () {
          searchFieldController.clear();
          FocusManager.instance.primaryFocus?.unfocus();
          templeListNotifier!.value = loadedTempleList;
          showFilterWidget.value = false;
        },
        icon: const Icon(
          Icons.clear_rounded,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
