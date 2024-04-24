import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../../../config/common/widgets/app_header.dart';
import 'language_changer.dart';

appBar(BuildContext context, dynamic temple) {
  return appHeader(
    context: context,
    leadingAvail: true,
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        Locales.lang == "en"
            ? temple!.templeName.split(',')[0] ?? '-'
            : temple!.ttempleName.split(',')[0] ?? "-",
        softWrap: true,
        textAlign: TextAlign.center,
        maxLines: 3,
        style: Locales.lang == "en"
            ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                )
            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
      ),
    ),
    trailing: Align(
      alignment: Alignment.centerRight,
      child: languageChanger(context),
    ),
  );
}
