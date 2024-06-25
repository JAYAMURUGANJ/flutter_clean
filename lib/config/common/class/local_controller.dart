import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  var locale = const Locale('en').obs;

  void changeLocale(String langCode) {
    var newLocale = Locale(langCode);
    locale.value = newLocale;
    Get.updateLocale(newLocale);
  }

  String get currentLanguage => locale.value.languageCode;
}
