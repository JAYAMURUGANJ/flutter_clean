import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

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
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LocaleText(
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child:
                    Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ),
            ],
          ),
        )
      : const SizedBox.shrink();
}
