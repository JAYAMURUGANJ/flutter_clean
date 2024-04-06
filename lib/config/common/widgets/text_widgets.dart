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
