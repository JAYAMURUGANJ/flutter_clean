class LiveSteamType {
  String steamType;
  String tsteamType;
  String imageLink;
  // String contentType;
  String liveurlType;
  String liveUrl;
  LiveSteamType({
    required this.steamType,
    required this.tsteamType,
    required this.imageLink,
    // required this.contentType,
    required this.liveurlType,
    required this.liveUrl,
  });

  factory LiveSteamType.fromJson(Map<String, dynamic> jsonData) {
    return LiveSteamType(
      steamType: jsonData['steamType'],
      tsteamType: jsonData['tsteamType'],
      imageLink: jsonData['imageLink'],
      //  contentType: jsonData['contentType'],
      liveurlType: jsonData['liveurlType'],
      liveUrl: jsonData['liveUrl'],
    );
  }

  static Map<String, dynamic> toMap(LiveSteamType bookingServices) => {
        'steamType': bookingServices.steamType,
        'tsteamType': bookingServices.tsteamType,
        'imageLink': bookingServices.imageLink,
        // 'contentType': bookingServices.contentType,
        'liveurlType': bookingServices.liveurlType,
        'liveUrl': bookingServices.liveUrl,
      };
}
