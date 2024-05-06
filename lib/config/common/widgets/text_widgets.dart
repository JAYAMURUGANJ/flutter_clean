import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/config/constants.dart';

LocaleText buildHeading(BuildContext context, String text) {
  return LocaleText(
    text,
    style: Theme.of(context)
        .textTheme
        .labelSmall!
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
              Text(value,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        )
      : const SizedBox.shrink();
}
