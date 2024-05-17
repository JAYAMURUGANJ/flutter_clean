import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
}

extension CustomSizedBox on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

extension StringExtension on String {
  String? get youtubeLiveUrl {
    if (youtubeVideoId == null) {
      return "";
    } else {
      var parts = split('/');
      var prefix = parts[3];
      if (prefix == 'live') {
        return parts[4];
      } else {
        return '';
      }
    }
  }

  String? get youtubeVideoId {
    final regex = RegExp(
        r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?',
        caseSensitive: false);

    try {
      if (regex.hasMatch(this)) {
        return regex.firstMatch(this)!.group(1);
      }
    } catch (e) {
      return '';
    }
    return null;
  }

  String? youtubeImageUrl() {
    if (youtubeLiveUrl == null) {
      return null;
    } else {
      return YoutubePlayer.convertUrlToId(this)!;
    }
  }
}
