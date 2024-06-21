import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:news_app_clean_architecture/config/config.dart';

class ConfigLoader {
  final String environment;

  ConfigLoader({required this.environment});

  Future<Config> load() async {
    try {
      print("load entered");
      final String configString =
          await rootBundle.loadString('config/$environment.json');
      print("load entered 2");
      final configJson = json.decode(configString);
      print("load entered 3");
      return Config.fromJson(configJson);
    } catch (e) {
      return Config(apiBaseUrl: "", debug: false);
    }
  }
}
