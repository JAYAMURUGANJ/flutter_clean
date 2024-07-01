class Config {
  final String apiBaseUrl;
  final bool debug;

  Config({required this.apiBaseUrl, required this.debug});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      apiBaseUrl: json['apiBaseUrl'],
      debug: json['debug'],
    );
  }
}