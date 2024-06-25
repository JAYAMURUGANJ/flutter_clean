import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/common/class/local_controller.dart';

languageChanger(BuildContext context) {
  final LocalizationController localizationController =
      Get.find<LocalizationController>();
  return localizationController.currentLanguage == 'en'
      ? IconButton(
          onPressed: () => localizationController.changeLocale("ta"),
          isSelected: true,
          icon: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "அ",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: FontStyle.normal,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        )
      : IconButton(
          onPressed: () => localizationController.changeLocale("en"),
          isSelected: true,
          icon: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "A",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontStyle: FontStyle.normal,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        );
}
