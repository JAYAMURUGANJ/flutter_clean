import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension UrlValidator on String {
  bool isUrl() {
    try {
      Uri.parse(this);
      return true;
    } catch (_) {
      return false;
    }
  }
}

extension DataToString on dynamic {
  String get toStringForm {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this).toString();
  }

  String get indianDateFormat {
    return DateFormat('dd-MM-yyyy').format(this).toString();
  }
}

extension CustomSizedBox on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

extension StringExtension on String {
  String? get youtubeVideoId {
    final regex = RegExp(
        r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu\.be))(\/(?:[\w\-]+\?v=|embed\/|v\/|live\/)?)([\w\-]+)(\S+)?',
        caseSensitive: false);

    try {
      if (regex.hasMatch(this)) {
        return regex.firstMatch(this)?.group(5);
      }
    } catch (e) {
      return '';
    }
    return null;
  }

  String? get youtubeLiveUrl {
    if (youtubeVideoId == null) {
      return "";
    } else {
      var parts = split('/');
      if (parts.length > 4 && parts[3] == 'live') {
        return parts[4];
      } else {
        return '';
      }
    }
  }

  String? youtubeImageUrl() {
    if (youtubeVideoId == null) {
      return null;
    } else {
      return 'https://img.youtube.com/vi/$youtubeVideoId/0.jpg';
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime get today => DateTime(year, month, day);
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
