import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/app_logo.dart';
import '../../../../config/constants.dart';

//Temple contact information
buildBottomSheet(context, dynamic temple, String sheetTitle, Widget body) {
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

buildContactCard(BuildContext context, String lable, String value,
    IconData icon, VoidCallback action,
    {bool localLable = true}) {
  return Padding(
    padding: defaultPadding,
    child: ListTile(
      onTap: action,
      trailing: IconButton(
        icon: Icon(icon),
        highlightColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        hoverColor: Colors.white,
        onPressed: action,
      ),
      title: localLable
          ? LocaleText(
              lable,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            )
          : Text(
              "Designation for Temple Inchager",
              softWrap: true,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
      subtitle: Text(
        value,
        maxLines: 4,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w500),
      ),
    ),
  );
}
