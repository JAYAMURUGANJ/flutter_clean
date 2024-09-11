import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app_clean_architecture/core/models/live_stream.dart';

import '/core/models/booking_services.dart';
import '/core/models/god.dart';

class ApiCredentials {
  // app name
  static const String appName = "Thirukoil";
  static const String tAppName = "திருக்கோயில்";

  // api credentials
  static String? requestorUserPwd = dotenv.env['REQUESTER_USER_PWD'];
  // for encryption & decryption of requests and responses
  static String? keyUTF8 = dotenv.env['KEYUTF8'];
  static String? ivUTF8 = dotenv.env['IVUTF8'];

  // version date for the appliction version when it was launched
  static String? versionData = dotenv.env['VERSION_DATE'];
  static const String requestorUserId = 'hrcevendor1';
  static const String serviceRequester = 'HRCEVENDR1';

  static String? filePath = dotenv.env['FILE_PATH'];
}

class LocalImages {
  // Network images URLs
  String dioError = "assets/images/icons/dio_error.png";
  static const String somthingWentWrong = "assets/images/icons/went_wrong.png";
  String noDataAvailable = "assets/images/icons/no_data_found.png";
  String noEventAvailable = "assets/images/icons/no_event.png";
  String noLiveAvailable = "assets/images/icons/no_live.png";
  String noNearByTemple = "assets/images/icons/no_temple.png";
  String logo = "assets/images/logo/logo.png";
  String appLogo = "assets/images/logo/app_logo.png";
  String tnLogo = "assets/images/logo/tn_logo.png";
  String splashBg = "assets/images/bg/splash.jpg";
  String location = "assets/images/icons/location.png";
  String degreeView = "assets/images/icons/360_degree.png";
  String contact = "assets/images/icons/contact.png";
  String mapMarker = "assets/images/icons/map_maker.png";
  String drawerBg = "assets/images/icons/drawer_bg.png";
  String play = "assets/images/icons/media-play.png";
  String wm = "assets/images/bg/water_mark.png";
  String networkError = "assets/images/icons/network_error.png";

  String templePlaceHolder =
      "https://www.tripsavvy.com/thmb/QW72TY8cFl91jto3DQJQwzf8mlw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/_DSC1048_Snapseed-56a3bd775f9b58b7d0d38fee.jpg";
}

//For payment screen
class LottieImage {
  String pop = "assets/images/lottie/pop.json";
  String success = "assets/images/lottie/success.json";
  String loading = "assets/images/lottie/loading.json";
}

// map radius list
List<double> distanceList = [5, 10, 15, 20, 25, 30];

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
    name: "food",
    imageLink: "assets/images/icons/food.png",
    bgColor: Colors.yellow.shade500,
    page: "",
  ),
  TempleServices(
    id: 4,
    name: "donation",
    imageLink: "assets/images/icons/donation.png",
    bgColor: Colors.deepOrange.shade300,
    page: "",
  ),
  TempleServices(
    id: 5,
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
    isBottomSheet: true,
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
      isBottomSheet: true),
  TempleServices(
      id: 4,
      name: "shrine",
      imageLink: "assets/images/icons/shrine.png",
      bgColor: Colors.lightGreen.shade300,
      page: "",
      isBottomSheet: true),
  TempleServices(
      id: 5,
      name: "live",
      imageLink: "assets/images/icons/live.png",
      bgColor: Colors.black.withAlpha(255),
      page: "",
      isBottomSheet: true),
  TempleServices(
      id: 6,
      name: "events",
      imageLink: "assets/images/icons/events.png",
      bgColor: Colors.lightBlue.shade300,
      page: "",
      isBottomSheet: true),
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
    page: "/Events",
  ),
  TempleServices(
    id: 3,
    name: "near_by_temples",
    imageLink: "assets/images/icons/near_temple.png",
    bgColor: Colors.deepOrange.shade300,
    page: "/NearByTemples",
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
    page: "/Livestream",
  ),
];

// Navigation Drawer Services list
List<TempleServices> drawerList = [
  TempleServices(
    id: 1,
    name: "home",
    imageLink: "assets/images/icons/home.png",
    bgColor: Colors.deepPurple.shade300,
    page: "Home",
  ),
  TempleServices(
    id: 2,
    name: "temples",
    imageLink: "assets/images/icons/temple.png",
    bgColor: Colors.amber.shade300,
    page: "TempleList",
  ),
  TempleServices(
    id: 3,
    name: "Booking",
    imageLink: "assets/images/icons/booking.png",
    bgColor: Colors.lightBlue.shade300,
    page: "/BookingService",
  ),
  TempleServices(
    id: 4,
    name: "settings",
    imageLink: "assets/images/icons/setting.png",
    bgColor: Colors.lightGreen.shade300,
    page: "/Settings",
  ),
];

List<LiveSteamType> liveStreamType = [
  LiveSteamType(
    liveurlType: "U",
    steamType: "Utchavar\nDarshan",
    tsteamType: "உச்சவர்\nதரிசனம்",
    liveUrl: "Y",
    imageLink: "assets/images/icons/urchavar_dharsan.png",
  ),
  LiveSteamType(
    liveurlType: "F",
    steamType: "Temple\nFestival",
    tsteamType: "கோவில்\nதிருவிழா",
    liveUrl: "Y",
    imageLink: "assets/images/icons/festival.png",
  ),
  LiveSteamType(
    liveurlType: "C",
    steamType: "Golden\nChariot",
    tsteamType: "தங்க ரத\nதேர்",
    liveUrl: "Y",
    imageLink: "assets/images/icons/goldan_chariet.png",
  ),
  LiveSteamType(
    liveurlType: "H",
    steamType: "Hundial\nCounting",
    tsteamType: "உண்டியல்\nஎண்ணுதல்",
    liveUrl: "Y",
    imageLink: "assets/images/icons/hundial_counting.png",
  ),
];

List<Color> colors = [
  Colors.deepPurple.shade300,
  Colors.lightGreen.shade300,
  Colors.deepOrange.shade300,
  Colors.lightBlue.shade300,
];

EdgeInsetsGeometry defaultPadding = const EdgeInsets.symmetric(horizontal: 12);

// common test themes
appbarTextStyleLarge(theme) => theme.textTheme.titleMedium!
    .copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold);
appbarTextStyleMedium(theme) =>
    theme.textTheme.titleSmall!.copyWith(color: theme.colorScheme.primary);

class MapStyle {
  final String aubergine = """
    [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#1d2c4d"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#8ec3b9"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1a3646"
          }
        ]
      },
      {
        "featureType": "administrative.country",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#4b6878"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#64779e"
          }
        ]
      },
      {
        "featureType": "administrative.province",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#4b6878"
          }
        ]
      },
      {
        "featureType": "landscape.man_made",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#334e87"
          }
        ]
      },
      {
        "featureType": "landscape.natural",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#023e58"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#283d6a"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#6f9ba5"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1d2c4d"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#023e58"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#3C7680"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#304a7d"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#98a5be"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1d2c4d"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2c6675"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#255763"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#b0d5ce"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#023e58"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#98a5be"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1d2c4d"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#283d6a"
          }
        ]
      },
      {
        "featureType": "transit.station",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#3a4762"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#0e1626"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#4e6d70"
          }
        ]
      }
    ]""";

  final String sliver = """
    [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#f5f5f5"
          }
        ]
      },
      {
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#616161"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#f5f5f5"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#bdbdbd"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#eeeeee"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#757575"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#e5e5e5"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9e9e9e"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#ffffff"
          }
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#757575"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dadada"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#616161"
          }
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9e9e9e"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#e5e5e5"
          }
        ]
      },
      {
        "featureType": "transit.station",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#eeeeee"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#c9c9c9"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9e9e9e"
          }
        ]
      }
    ]""";

  final String retro = """
    [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#ebe3cd"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#523735"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#f5f1e6"
          }
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#c9b2a6"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#dcd2be"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#ae9e90"
          }
        ]
      },
      {
        "featureType": "landscape.natural",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dfd2ae"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dfd2ae"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#93817c"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#a5b076"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#447530"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#f5f1e6"
          }
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#fdfcf8"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#f8c967"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#e9bc62"
          }
        ]
      },
      {
        "featureType": "road.highway.controlled_access",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#e98d58"
          }
        ]
      },
      {
        "featureType": "road.highway.controlled_access",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#db8555"
          }
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#806b63"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dfd2ae"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#8f7d77"
          }
        ]
      },
      {
        "featureType": "transit.line",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#ebe3cd"
          }
        ]
      },
      {
        "featureType": "transit.station",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#dfd2ae"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#b9d3c2"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#92998d"
          }
        ]
      }
    ]""";

  final String dark = """
    [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#212121"
          }
        ]
      },
      {
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#757575"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#212121"
          }
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#757575"
          }
        ]
      },
      {
        "featureType": "administrative.country",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9e9e9e"
          }
        ]
      },
      {
        "featureType": "administrative.land_parcel",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "administrative.locality",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#bdbdbd"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#757575"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#181818"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#616161"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#1b1b1b"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [
          {
            "color": "#2c2c2c"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#8a8a8a"
          }
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#373737"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#3c3c3c"
          }
        ]
      },
      {
        "featureType": "road.highway.controlled_access",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#4e4e4e"
          }
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#616161"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#757575"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#000000"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#3d3d3d"
          }
        ]
      }
    ]""";

  final String night = """
    [
      {
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#242f3e"
          }
        ]
      },
      {
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#746855"
          }
        ]
      },
      {
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#242f3e"
          }
        ]
      },
      {
        "featureType": "administrative.locality",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#d59563"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#d59563"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#263c3f"
          }
        ]
      },
      {
        "featureType": "poi.park",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#6b9a76"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#38414e"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#212a37"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#9ca5b3"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#746855"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "color": "#1f2835"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#f3d19c"
          }
        ]
      },
      {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#2f3948"
          }
        ]
      },
      {
        "featureType": "transit.station",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#d59563"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#17263c"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#515c6d"
          }
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#17263c"
          }
        ]
      }
    ]""";
}
