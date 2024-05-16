class LiveSteamType {
  String steamType;
  String tsteamType;
  String imageLink;
  String contentType;
  String liveurlType;
  LiveSteamType(
      {required this.contentType,
      required this.liveurlType,
      required this.steamType,
      required this.imageLink,
      required this.tsteamType});

  factory LiveSteamType.fromJson(Map<String, dynamic> jsonData) {
    return LiveSteamType(
      steamType: jsonData['steamType'],
      tsteamType: jsonData['tsteamType'],
      imageLink: jsonData['imageLink'],
      contentType: jsonData['contentType'],
      liveurlType: jsonData['liveurlType'],
    );
  }

  static Map<String, dynamic> toMap(LiveSteamType bookingServices) => {
        'steamType': bookingServices.steamType,
        'tsteamType': bookingServices.tsteamType,
        'imageLink': bookingServices.imageLink,
        'contentType': bookingServices.contentType,
        'liveurlType': bookingServices.liveurlType,
      };
}
