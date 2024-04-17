import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app_clean_architecture/core/models/booking_services.dart';
import 'package:news_app_clean_architecture/core/models/god.dart';

class ApiCredentials {
  // api credentials
  static const String domain = "https://hrce.tn.gov.in/webservice/";
  static const String webService = "webservices.php";
  static const String filePath = "documentview.php?file_path=";

  static const String baseUrl = domain + webService;
  String documents = domain + filePath;

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

class LocalImages {
  String appLogo = "assets/images/logo/logo.png";
  String tnLogo = "assets/images/logo/tn_logo.png";
}

// God list
List<God> godList = [
  God(
    id: 1,
    name: "Vinayagar Temple ",
    tName: "விநாயகர் கோயில்",
    imageLink: "assets/images/god/vinayagar.png",
    bgColor: Colors.deepOrange.shade300,
  ),
  God(
    id: 2,
    name: "Shivan temple",
    tName: "சிவன் கோயில்",
    imageLink: "assets/images/god/shivan.png",
    bgColor: Colors.blue.shade300,
  ),
  God(
    id: 7,
    name: "Perumal Temple",
    tName: "பெருமாள் கோயில்",
    imageLink: "assets/images/god/perumal.png",
    bgColor: Colors.deepPurple.shade300,
  ),
  God(
    id: 3,
    name: "Murugan Temple ",
    tName: "முருகன் கோயில்",
    imageLink: "assets/images/god/murugan.png",
    bgColor: Colors.deepOrange.shade300,
  ),
  God(
    id: 4,
    name: "Amman Temple",
    tName: "அம்மன் கோயில்",
    imageLink: "assets/images/god/amman.png",
    bgColor: Colors.blue.shade300,
  ),
  //13,14,15,16

  // God(id:5,name: "ஐயப்பன் கோயில்", imageLink: "assets/ayyappan.png"),
  // God(id:9,name: "ஆஞ்சநேயர் கோயில்", imageLink: "assets/hanuman.png"),
  // God(id:11,name: "நரசிம்மர் கோயில்", imageLink: "assets/narasimar.png"),
];

// devotee Services list
List<TempleServices> bookingServicesList = [
  TempleServices(
    id: 1,
    name: "paid",
    imageLink: "assets/images/icons/paid.png",
    bgColor: Colors.deepPurple.shade300,
    page: "/PaidService",
  ),
  TempleServices(
    id: 2,
    name: "free",
    imageLink: "assets/images/icons/free.png",
    bgColor: Colors.lightBlue.shade300,
    page: "",
  ),
  TempleServices(
    id: 3,
    name: "donation",
    imageLink: "assets/images/icons/donation.png",
    bgColor: Colors.deepOrange.shade300,
    page: "",
  ),
  TempleServices(
    id: 4,
    name: "postal_prasadam",
    imageLink: "assets/images/icons/postal.png",
    bgColor: Colors.lightGreen.shade300,
    page: "",
  ),
];
// temple Services list
List<TempleServices> templeServicesList = [
  TempleServices(
    id: 1,
    name: "Facility",
    imageLink: "assets/images/icons/facility.png",
    bgColor: Colors.deepOrange.shade300,
    page: "",
  ),
  TempleServices(
    id: 2,
    name: "booking",
    imageLink: "assets/images/icons/booking.png",
    bgColor: Colors.lightBlue.shade300,
    page: "/BookingService",
  ),
  TempleServices(
    id: 3,
    name: "sculpture",
    imageLink: "assets/images/icons/sculpture.png",
    bgColor: Colors.indigo.shade300,
    page: "",
  ),
  TempleServices(
    id: 4,
    name: "shrine",
    imageLink: "assets/images/icons/shrine.png",
    bgColor: Colors.lightGreen.shade300,
    page: "",
  ),
  TempleServices(
    id: 5,
    name: "live",
    imageLink: "assets/images/icons/live.png",
    bgColor: Colors.black.withAlpha(255),
    page: "",
  ),
  TempleServices(
    id: 6,
    name: "events",
    imageLink: "assets/images/icons/events.png",
    bgColor: Colors.lightBlue.shade300,
    page: "",
  ),
];
// other Services list
List<TempleServices> otherServicesList = [
  TempleServices(
    id: 1,
    name: "books",
    imageLink: "assets/images/icons/book.png",
    bgColor: Colors.deepPurple.shade300,
    page: "",
  ),
  TempleServices(
    id: 2,
    name: "events",
    imageLink: "assets/images/icons/events.png",
    bgColor: Colors.lightBlue.shade300,
    page: "",
  ),
  TempleServices(
    id: 3,
    name: "near_by_temples",
    imageLink: "assets/images/icons/near_temple.png",
    bgColor: Colors.deepOrange.shade300,
    page: "",
  ),
  TempleServices(
    id: 5,
    name: "divya_prabandam",
    imageLink: "assets/images/icons/divya_prabandam.png",
    bgColor: Colors.lightGreen.shade300,
    page: "",
  ),
  TempleServices(
    id: 4,
    name: "thirumurai",
    imageLink: "assets/images/icons/thirumurai.png",
    bgColor: Colors.yellow.shade300,
    page: "",
  ),
  TempleServices(
    id: 6,
    name: "live",
    imageLink: "assets/images/icons/live.png",
    bgColor: Colors.black.withAlpha(255),
    page: "",
  ),
];

List<Color> colors = [
  Colors.deepPurple.shade300,
  Colors.lightGreen.shade300,
  Colors.deepOrange.shade300,
  Colors.lightBlue.shade300,
];

EdgeInsetsGeometry defaultPadding =
    const EdgeInsets.symmetric(horizontal: 12, vertical: 5);
