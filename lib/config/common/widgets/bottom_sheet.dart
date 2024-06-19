import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/config/common/widgets/app_logo.dart';

buildBottomSheet(
  ctx,
  dynamic data,
  String sheetTitle,
  Widget body,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    useSafeArea: true,
    useRootNavigator: true,
    context: ctx,
    builder: (bottomSheetContext) {
      return Scaffold(
        appBar: buildBottomSheetAppBar(bottomSheetContext, sheetTitle),
        body: body,
      );
    },
  );
}

buildBottomSheetAppBar(BuildContext bottomSheetContext, String sheetTitle) {
  return AppBar(
    elevation: 0,
    leading: const Padding(
      padding: EdgeInsets.all(4.0),
      child: AppIcon(height: 50),
    ),
    actions: [
      IconButton(
        onPressed: () {
          try {
            Navigator.of(bottomSheetContext).pop();
          } on Exception {
            rethrow;
          }
        },
        icon: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    ],
    backgroundColor: Theme.of(bottomSheetContext).colorScheme.primary,
    title: LocaleText(
      sheetTitle,
      textAlign: TextAlign.center,
      style: Theme.of(bottomSheetContext)
          .textTheme
          .titleLarge!
          .copyWith(color: Colors.white),
    ),
  );
}
