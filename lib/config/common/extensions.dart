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
