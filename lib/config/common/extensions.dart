import 'package:dio/dio.dart';
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
    final regex1 = RegExp(
        r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?',
        caseSensitive: false);

    try {
      if (regex1.hasMatch(this)) {
        return regex1.firstMatch(this)!.group(1);
      } else {}
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

  Future<String> getLiveVideoId() async {
    var dio = Dio();
    debugPrint(this);
    String urls =
        'https://www.youtube.com/channel/UCPP3etACgdUWvizcES1dJ8Q/live';
    RegExp regExp = RegExp(r"(?<=channel\/)(.*?)(?=\/live)");
    String channelId = regExp.firstMatch(urls)?.group(0) ?? '';
    var url = 'https://www.googleapis.com/youtube/v3/search'
        '?part=snippet'
        '&channelId=$channelId'
        '&eventType=live'
        '&type=video'
        '&key=AIzaSyAe-8b7JH3eiu2UrfxwKFGjofRqeGfnR3g';

    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        var items = jsonResponse['items'];
        if (items.length > 0) {
          return items[0]['id']['videoId'];
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return "";
  }
}
