import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:news_app_clean_architecture/config/constants.dart';

LocaleText buildHeadingText(BuildContext context, String text) {
  return LocaleText(
    text,
    style: Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.bold),
  );
}

Widget buildlabelValueTxt(BuildContext context, String title, String? value) {
  return value != null
      ? Padding(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LocaleText(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        )
      : const SizedBox.shrink();
}
