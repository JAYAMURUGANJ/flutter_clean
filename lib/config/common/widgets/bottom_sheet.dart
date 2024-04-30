import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/common/widgets/app_logo.dart';

buildBottomSheet(context, dynamic data, String sheetTitle, Widget body) {
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Scaffold(
        appBar: buildBottomSheetAppBar(context, sheetTitle),
        body: body,
      );
    },
  );
}

buildBottomSheetAppBar(BuildContext context, String sheetTitle) {
  return AppBar(
    elevation: 0,
    leading: const Padding(
      padding: EdgeInsets.all(4.0),
      child: AppIcon(height: 50),
    ),
    actions: [
      IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    ],
    backgroundColor: Theme.of(context).colorScheme.primary,
    title: LocaleText(
      sheetTitle,
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
    ),
  );
}
