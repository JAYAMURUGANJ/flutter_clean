import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/itms/itms_bloc.dart';
import '../bloc/itms/itms_event.dart';

TextField searchWidget(BuildContext context, searchFieldController) {
  return TextField(
    controller: searchFieldController,
    onChanged: (value) {
      BlocProvider.of<ITMSBloc>(context).add(FilterTempleList(value));
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
          BlocProvider.of<ITMSBloc>(context).add(FilterTempleList(""));
        },
        icon: const Icon(
          Icons.clear_rounded,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
