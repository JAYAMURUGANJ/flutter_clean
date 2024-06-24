import 'package:news_app_clean_architecture/features/temple_list/domain/entities/temple_list.dart';

// var templeDetail = {
//   "temple_id: 38367,
//   "temple_name: "Arulmigu Thanumalayan Temple, Suchindrum - 629704",
//   "ttemple_name: "அருள்மிகு தாணுமாலயன் திருக்கோயில், சுசீந்திரம் - 629704",
//   "juris_office_code: 12,
//   "district_code: "30",
//   "taluk_code: "01",
//   "village_code: "002",
//   "temple_typecode: 1,
//   "institute_categorycode: 1,
//   "templesection_code: 6,
//   "management_typecode: 1,
//   "management_subtype_code: 3,
//   "worship_code: 2,
//   "url_templewebsite:
//       "https://hrce.tn.gov.in/hrcehome/index_temple.php?tid=38367&lang=TA&color=910101&mobileview=Y",
//   "url_templeservice:
//       "https://hrce.tn.gov.in/ticketing/service_collectionindex.php?tid=38367&scode=21&sscode=1&target_type=1&group_id=4&lang=TA&color=910101&mobileview=Y",
//   "postal_avail: "Y",
//   "url_prasadamservice:
//       "https://hrce.tn.gov.in/ticketing/service_collectionindex.php?tid=38367&scode=21&sscode=1&target_type=1&group_id=4&chargetype_id=4&lang=TA&color=910101&mobileview=Y",
//   "url_donationservice:
//       "https://hrce.tn.gov.in/ticketing/service_collectionindex.php?tid=38367&scode=21&sscode=1&target_type=1&group_id=0&lang=TA&color=910101&mobileview=Y",
//   "annadhanam_enabled: "Y",
//   "degree360_avail: "Y",
//   "degree_360view:
//       "https://hrce.tn.gov.in/resources/docs/virtualtour/38367/index.html?lang=TA&color=910101",
//   "temple_latitude: "8.1551122508043",
//   "temple_langitude: "77.465801155635",
//   "maintower_image: [
//     {
//       "file_location:
//           "aHJjZXBhdGgvdGVtcGxlaW5mby9nZW5lcmFsL3Rvd2VyLzM4MzY3L2ltYWdlXzEuanBn"
//     }
//   ]
// };

// TempleListResponseEntity temple =
//     TempleListResponseEntity.fromJson(templeDetail);

final mockListOfTemple = [
  const TempleListEntity(
      templeId: 38367,
      templeName: "Arulmigu Thanumalayan Temple, Suchindrum - 629704",
      ttempleName: "அருள்மிகு தாணுமாலயன் திருக்கோயில், சுசீந்திரம் - 629704",
      jurisOfficeCode: 12,
      districtCode: "30",
      talukCode: "01",
      villageCode: "002",
      templeTypecode: 1,
      instituteCategorycode: 1,
      templesectionCode: 6,
      managementTypecode: 1,
      managementSubtypecode: 3,
      worshipCode: 2,
      urlTemplewebsite:
          "https://hrce.tn.gov.in/hrcehome/index_temple.php?tid=38367&lang=TA&color=910101&mobileview=Y",
      postalAvail: "Y",
      annadhanamEnabled: "Y",
      degree360Avail: "Y",
      degree360view:
          "https://hrce.tn.gov.in/resources/docs/virtualtour/38367/index.html?lang=TA&color=910101",
      templeLatitude: "8.1551122508043",
      templeLangitude: "77.465801155635",
      maintowerImage: [
        MaintowerImage(
            fileLocation:
                "aHJjZXBhdGgvdGVtcGxlaW5mby9nZW5lcmFsL3Rvd2VyLzM4MzY3L2ltYWdlXzEuanBn")
      ])
];
