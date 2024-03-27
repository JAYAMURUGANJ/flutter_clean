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
}
