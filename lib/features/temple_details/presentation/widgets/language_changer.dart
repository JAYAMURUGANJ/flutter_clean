import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

languageChanger(BuildContext context) {
  return context.currentLocale!.languageCode == 'en'
      ? IconButton(
          onPressed: () => context.changeLocale("ta"),
          icon: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "அ",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        )
      : IconButton(
          onPressed: () => context.changeLocale("en"),
          icon: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "A",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        );
}
