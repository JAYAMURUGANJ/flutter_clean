import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiCredentials {
  // api credentials
  static const String baseUrl =
      "https://hrce.tn.gov.in/demoapp/webservice/webservices.php";
  static String? requestorUserPwd = dotenv.env['REQUESTER_USER_PWD'];

  // for encryption & decryption of requests and responses
  static String? keyUTF8 = dotenv.env['KEYUTF8'];
  static String? ivUTF8 = dotenv.env['IVUTF8'];

  static const String requestorUserId = 'hrcevendor1';
  static const String serviceRequester = 'HRCEVENDR1';
}

class NetworkImages {
  // Network images URLs
  static const String dioError =
      "https://static.vecteezy.com/system/resources/previews/026/766/398/non_2x/error-server-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg";

  static const String somthingWentWrong =
      "https://static.vecteezy.com/system/resources/previews/012/003/110/large_2x/information-not-found-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg";
}
