import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/app_header.dart';
import 'language_changer.dart';

appBar(BuildContext context, dynamic temple) {
  return appHeader(
    context: context,
    leadingAvail: false,
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        Locales.lang == "en"
            ? temple!.templeName ?? '-'
            : temple!.ttempleName ?? "-",
        softWrap: true,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    ),
    trailing: languageChanger(context),
  );
}
