import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app_clean_architecture/core/models/god.dart';

class ApiCredentials {
  // api credentials
  static const String domain = "https://hrce.tn.gov.in/webservice/";
  static const String webService = "webservices.php";
  static const String filePath = "documentview.php?file_path=";

  static const String baseUrl = domain + webService;
  static const String documents = domain + filePath;

  static String? requestorUserPwd = dotenv.env['REQUESTER_USER_PWD'];

  // for encryption & decryption of requests and responses
  static String? keyUTF8 = dotenv.env['KEYUTF8'];
  static String? ivUTF8 = dotenv.env['IVUTF8'];

  // version date for the appliction version when it was launched
  static String? versionData = dotenv.env['VERSION_DATE'];

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

// God list
List<God> godList = [
  God(
      id: 1,
      name: "Vinayagar Temple ",
      tName: "விநாயகர் கோயில்",
      imageLink: "assets/images/icons/vinayagar.png"),
  God(
      id: 2,
      name: "Shivan temple",
      tName: "சிவன் கோயில்",
      imageLink: "assets/images/icons/shivan.png"),
  God(
      id: 7,
      name: "Perumal Temple",
      tName: "பெருமாள் கோயில்",
      imageLink: "assets/images/icons/perumal.png"),
  God(
      id: 3,
      name: "Murugan Temple ",
      tName: "முருகன் கோயில்",
      imageLink: "assets/images/icons/murugan.png"),
  God(
      id: 4,
      name: "Amman Temple",
      tName: "அம்மன் கோயில்",
      imageLink: "assets/images/icons/amman.png"),
  //13,14,15,16

  // God(id:5,name: "ஐயப்பன் கோயில்", imageLink: "assets/ayyappan.png"),
  // God(id:9,name: "ஆஞ்சநேயர் கோயில்", imageLink: "assets/hanuman.png"),
  // God(id:11,name: "நரசிம்மர் கோயில்", imageLink: "assets/narasimar.png"),
];
