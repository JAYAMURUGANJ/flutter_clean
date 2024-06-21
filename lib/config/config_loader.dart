import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:news_app_clean_architecture/config/config.dart';

class ConfigLoader {
  final String environment;

  ConfigLoader({required this.environment});

  Future<Config> load() async {
    try {
      final String configString =
          await rootBundle.loadString('config/$environment.json');
      final configJson = json.decode(configString);
      return Config.fromJson(configJson);
    } catch (e) {
      return Config(apiBaseUrl: "", debug: false);
    }
  }
}
