import 'package:flutter/foundation.dart';

class ApiCredentials {
  // api credentials
  static const String baseUrl = kDebugMode
      ? 'https://hrce.tn.gov.in/demoapp/webservice/webservices.php'
      : "https://hrce.tn.gov.in/webservice/webservices.php";
  static const String requestorUserPwd =
      'd119518a934336d4676ba623e36d1b9902581777064452283ca46d1f8ead5913';
  static const String requestorUserId = 'hrcevendor1';
  static const String serviceRequester = 'HRCEVENDR1';
  // for encryption & decryption of requests and responses
  static const String keyUTF8 = 'fWe6qWEJCWb2gcH4+APJL1YmtZmn0NVS';
  static const String ivUTF8 = 'c1aeB65F17A1c7f3';
}

class NetworkImages {
  // Network images URLs
  static const String dioError =
      "https://static.vecteezy.com/system/resources/previews/026/766/398/non_2x/error-server-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg";

  static const String somthingWentWrong =
      "https://static.vecteezy.com/system/resources/previews/012/003/110/large_2x/information-not-found-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg";
}
