import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/models/itms_request.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../../../core/resources/itms_request_handler.dart';
import '../../../domain/usecases/itms_response.dart';
import 'itms_event.dart';
import 'itms_state.dart';

class ITMSBloc extends Bloc<ITMSEvent, ITMSState> {
  final ItmsResponseUseCase _getItmsResponseUseCase;

  ITMSBloc(this._getItmsResponseUseCase) : super(const TempleListLoading()) {
    on<GetTempleHistory>(onGetTempleHistory);
    on<GetTempleSpecialty>(onGetTempleSpecialty);
    on<GetTemplePooja>(onGetTemplePooja);
    on<GetTempleTowers>(onGetTempleTowers);
    on<GetTempleInfo>(onGetTempleInfo);
    on<GetTempleTimes>(onGetTempleTimes);
    on<GetTempleLocation>(onGetTempleLocation);
    on<GetTempleContacts>(onGetTempleContacts);
    on<GetTempleAdmininfo>(onGetTempleAdmininfo);
    on<GetTemplePhotogallery>(onGetTemplePhotogallery);
    on<GetTempleVideogallery>(onGetTempleVideogallery);
    on<GetTempleScrollevent>(onGetTempleScrollevent);
    on<GetTempleWhatsnew>(onGetTempleWhatsnew);
    on<GetTempleFacility>(onGetTempleFacility);
    on<GetTempleList>(onGetTempleList);
  }

  void onGetTempleHistory(
      GetTempleHistory event, Emitter<ITMSState> emit) async {
    String serviceId = "7004";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    // [ { "result_set": [ { "history_typedesc": "History", "history_desc": "HISTORY OF ARULMIGU KAPALEESWARAR KARPAGAMBAL TEMPLE\r \r * Goddess Uma in the guise of Peacock worshiped Lord Shiva \r * Lord Muruga got his Sakthivel from Lord Shiva and Mother Uma \r * Lord Brahma got back his job of creation after shedding his pride \r * Vedas worshiped Lord Kapaleeswarar and hence Mylai is known as Vedapuri \r * Sukaran prayed to Lord Shiva here. Hence Mylai is also called Sukarapuri \r * Lord Sri Rama stayed here and performed pujas to Lord Shiva with festivals \r * In this holy soil, Thirugnana Sambandar restored Poompavai from her ashes and preserved bones. \r * Birth place of saint Vaylar, one of the 63 saints \r * Birth place of peiazhwar, one of the twelve azhwars, \r * Saint Arunagirinathar sang the glory of Lord Singaravelan in Thirupugazh. \r * Birth place of great saint and poet Thiruvalluvar whose Thirukural is a classic Tamil Sangam literature consisting of 1330 couplets \r * On this holy soil, Saint Sambandhar sang the first piece of literature Muttatta Punnayam.", "history_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9oaXN0b3J5LzEvMS9pbWFnZV8xLmpwZw==" } ] }, { "history_typedesc": "Literary Background", "history_desc": "Literary Background\r The temple was also patronized by the great Tamil saint Thirugnana Sambandar. He sang the first hymn Matita Punnaiangal in praise of Kapaleeswarar and made Myalai famous as a divine worship centre. It was here that Sambandar restored Poompavai to life from the bones and ashes preserved by her father Sivanesar with the fond hope that one day she will come back to life. Poompavai father wanted her daughter to be married to a saint . But she died of snake bite and her father preserved the bones in a pot which he handed over to the child saint when he visited Mylai. Sambandar sang (10 verses Pathigam) with the beginning Mattita Punnai listing the various festivals of Lord Shiva", "history_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9oaXN0b3J5LzEvMy9pbWFnZV8xLmpwZw==" } ] }, { "history_typedesc": "Thala Puranam", "history_desc": "THALA PURANAM:\r \r The name Mylapore is derived from the legend that the Goddess Uma worshipped Siva in the form of a peacock (or mayil in Tamil). We can see a representation of this legend on stone in a small Shrine under a Punnai tree (Sthala Vriksha) in the Courtyard of the temple. Once, Goddess Uma desired to know the complete interpretation of the five letter mantra Na Ma Shi Va and the splender of the sacred ash (Vibuthi). Goddess Uma persuaded Shiva to touch teach her. Shiva consented and commenced teaching. However Goddess Uma was distracted by a beautiful peacock nd her attention wandered. Siva was infuriated and cursed her to go to sacred Thondai Nadu and perform penance. Goddess Uma worshipped the Shivalinga under the punnai Tree in the temple vicinity. Moved by Goddess Uma utmost devotion, Lord appeared before Her and released Her from the curse and fondly called her as Karpagavalli. Goddess Uma requested Lord Shiva to name the place Mylapore and stay back with her to bestow blessings on all the devotees. Accordingly, Mylai became the abode of Kapaleeswarar and Karpagambal.\r \r \r There is another legend associated with Mylai being called Kapalesswaram. Lord Brahama thought that he was as great and equal to Lord Shiva as he too had five heads. Shiva known for his spontaneous reaction decided to teach Brahma a lesson and cut down his ego. Shiva nipped one head and held the skull in his hand. Therefore Lord Shiva was praised as Kapaleeswarar and the place of worship is called Kapaleeswaram.", "history_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9oaXN0b3J5LzEvMi9pbWFnZV8xLmpwZw==" } ] } ], "response_status": "SUCCESS" } ]
    if (dataState is DataFailed) {
      emit(TempleListLodingError(dataState.error!));
    }
  }

  void onGetTempleSpecialty(
      GetTempleSpecialty event, Emitter<ITMSState> emit) async {
    String serviceId = "7006";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    // [ { "result_set": [ { "speciality_desc": "Historical", "speciality_details": "The shrine has a legend behind it. The shrine of Singaravelar in Kapali Temple is unique. Lord Murugar took a bath here and made offerings to Parvathi and Parameshwarar. Both appeared before Murgar in this temple and gave Sakthi Vel.\r Murugar used Vel (a spear) to defeat all the evil forces of Soorapadman. The demon knew that he would be killed, so he transformed himself into a mango tree. Murgar hurled the Vel and split the tree into two halves. One becoming Seval (a rooster) and the other becoming Mayil (a peacock), the vehicle. One more rooster became the emblem of his battle flag. Thereafter, Murugar married Devasena and Valli. Here is the verse that gives this incident in a tiny doggerel:\r Eththalathin yelaru sathiver\r Petri yathular payaruku ena naam\r Vetri petra singara velavan\r Nootra naam muyarthi thantha thalam\r (The verse explains how Lord Murgar got the title of Singaravelar.\r The Singaravelar shrine is situated in a 64 square meter area. The shrine, which faces west, houses the images of Singaravelavar, Valli, and Devasena. Here Singaravelar sits on peacock, and his spouses on elephants. This is very unique in the world. Here, Singaravelar appears as Shanmugar. A separate flag post is in front of the sannadhi.", "speciality_title": "ARULMIGU SINGARAVELAR SANNATHI", "speciality_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9zcGVjaWFsaXRpZXMvMS80MjU5L2ltYWdlXzEuanBn" } ] }, { "speciality_desc": "Prayer", "speciality_details": "The ritual within this temple tends to be orthodox and elaborate in both Sanskrit and Tamil language. Apart from regular pujas, Shiva abhishekam is performed six times a day. The abhishekam is performed to Lingam representing his manifestation as creator of good.  The items in the abhishekam are curd, milk, honey, tender coconut water, vibhuthy, bananas, sandalwood paste and ghee. The temple rituals are performed six times a day. Each ritual comprises four steps: abhishekam (sacred bath), alangaram (decoration) neivethiayam (food offering) and deepa aradhana (waving of lamps) for both Kapaleeswarar and Karpagambal. The worship is held amidst music by Nadeswaram (pipe instrument and tavil (percussion instrument). \r The priest recites loudly the appropriate mantra during the rituals. \r Daily rituals commences at 5:30 with palliarai puja. The Go Pujai is done first. Vila pujai muthar kalams.8:30 kalasandhi puja in small shrines. 11 am ouchi kalam 12:30 close. Evening 4 pm opening, 4 15 abhishegam, and 5 PM deeparathanai. Procession of pradosha nayar and offer of rice as pali. 7 pm second kala puja 9 pm artha jama puja. Only Lord Kapali gets milk and panneer abhishegam and deeparadhanai. Paliarai swami procession. Concluding puja is for Kala Bairavar.", "speciality_title": "Details of temple worship", "speciality_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9zcGVjaWFsaXRpZXMvMS85L2ltYWdlXzEuanBn" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9zcGVjaWFsaXRpZXMvMS85L2ltYWdlXzIuanBn" } ] }, { "speciality_desc": "Purathanam", "speciality_details": "The eighth day is an important one. It is the Arupathu Moovar festival. The sixty three saints of Shiva are honoured. On this day Sambandar rises on the West Mada Street and he is given a special abhishegam along with Sivanesar. In the afternoon, both return to the temple with ashes of Poompavai. Sambandar composes seven verses to resurrect the dead Poompavai.  Each verse describes one festival of Kapali temple. Poompavai Pathigam also accounts Mayilai to be a flourishing settlement with groves and impressive buildings occupied by pious people. In the days of Sambandar, Siva came out in procession with his eighteen bhootas who are his attendants. \r On Arupattu Moover day, Siva comes out with his 63 saints, all of them preceding him in palanquins with their faces turned to Shiva, their palms pressed together in adulation. The added attraction of this festival is that deities from other temples join the pageant. Nearly two to three lakh people visit Mylapore on that day. Philanthropic organizations, individuals, traders, institutions   arrange for free food and water in abundance. \r It is a day when every visitor gets a free lunch and dinner. One interesting incident which happened in the early 20th century is recorded in a web site. A unique song associated with Arupattu Moovar festival is the Vazhinadi Chindu written by an unknown poet. The song is about a beau of George Town asking his girlfriend, a toast of Mullah Sahib Street to walk down with him to Mylapore to see the Arubattu Moovar festival at Kapaleeswarar temple. The composition is structured as though the hero is showing the sights of the city to his beloved as they travel to Mylapore. The route sited in the poem is the shortest and logical.\r In the night, the Lord comes on horseback (Pari vettai) and returns to the temple after receiving all poojas.", "speciality_title": "Arupathu Moovar festival", "speciality_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9zcGVjaWFsaXRpZXMvMS82L2ltYWdlXzEuanBn" } ] } ], "response_status": "SUCCESS" } ]
    if (dataState is DataFailed) {
      emit(TempleListLodingError(dataState.error!));
    }
  }

  void onGetTemplePooja(GetTemplePooja event, Emitter<ITMSState> emit) async {
    String serviceId = "7007";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    // [ { "result_set": [ { "pooja_desc": "Ko Pooja", "alangaram": "Flower and Kunkumam and Santhanam", "pooja_time": "05:30 AM to 06:00 AM" }, { "pooja_desc": "Vaikarai Pooja", "alangaram": "Abhishegam and Alangaram", "pooja_time": "06:00 AM to 07:00 AM" }, { "pooja_desc": "Kalasandhi pooja", "alangaram": "Abhishegam and Alangaram", "pooja_time": "08:00 AM to 09:30 PM" }, { "pooja_desc": "Uchikkala Pooja", "alangaram": "Abhishegam and Alangaram", "pooja_time": "11:00 AM to 12:30 PM" }, { "pooja_desc": "Sayaraksha Pooja (Evening)", "alangaram": "Abishegam and Alangaram", "pooja_time": "04:00 PM to 06:30 PM" }, { "pooja_desc": "Ushakala poojai", "alangaram": "", "pooja_time": "06:30 PM to 07:00 PM" }, { "pooja_desc": "Ardhajama Pooja", "alangaram": "Abhishegam and Alangaram", "pooja_time": "09:00 PM to 09:30 PM" } ], "response_status": "SUCCESS" } ]
    if (dataState is DataFailed) {
      emit(TempleListLodingError(dataState.error!));
    }
  }

  void onGetTempleTowers(GetTempleTowers event, Emitter<ITMSState> emit) async {
    String serviceId = "7008";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "tower_name": "Raja Gopuram", "settext": "", "statues_floor": "", "towerdimensions": "40x15x", "unit_desc": "Metre", "noof_kalasam": "9", "protector": "Yes", "tower_desc": "This Rajagopuram is 117 feet tall, and has 3800 dolls depicting different themes. The temple is a testimonial for the Vishwakarma sthapathis. There are seven inlays in this gopuram on all four sides. On the east side the Siva Murthangals are depicted as dolls. On the south side Dakshinamurthy (Siva murthangal) in eight different forms can be seen. Siva and Hari leelaigal are also depicted. On the west side the adventure of Hari (Vishnu) and few Nayanmars are seen. On the north side eight thiru kolangals are depicted. Anjaneya swami, Dikshithars, Siva devotees are well arranged. First layer the dolls reflect human lives like Rama, Chandikesvarar, Siva kudumbam and Neelakanta Dikshithar. On the second layer Gnanasambandar is shown. Third layer shows Sundara Murthy Nayanar and Gajari, urthathandavam. Fourth layer are Bhairavas and Dikpalars. Fifth layer ashta murthangal like Narasimhar, Sarabar and Krishna leela are seen.  On the fifth layer is also Siva Saiyuja Murthangal. On the sixth, are Siva Hamsa, Rudran, Easwaran, Maheshwaran, Brahma and Vishnu. On the seventh, only Siva Hamsam- Sadasiva Murtham and Karnam (space for lamp). &nbspIn ancient times, the light on top of the gopuraram served like light houses of today as most of the temples are located near the sea shore.There are nine kalasangals on top of the gopuram which depicts the nine different holes (nava dhwaram) in a human body. Gopuram is known as Sushma Lingam meaning the God inside temple is shown. The reason is that if one is unable to go to the temple, they can look at the Gopuram and get the same palan (benefit). The kalasam at the top is known as lsquoSthula lingamrsquo.  The tip of the kalasam is sushma lingam. The temple is divided into three parts viz Brahma Bagam, Vishnu Bagam, and top is Siva Bagam. The temple strictly adheres to Ayathi Sastharam of Silpa Shasthra. The sastra stipulates that the Rajagopuram should be 12 times that of the main deity. The rock foundation of the main gopuram reflects the contribution of Pallavas and Vijayanagar Kingdom. The dolls of the gopuram came into existence in the 19th century. Before that it was only long rock pillars. The varagu rice inside the kalasams serves as a lightning arrestor. The kalasam rests on red wood which takes the shock of lightning.The temple is enclosed by a compound wall (mathil) with the main entrance with gopuram in the east.There are two entrances to the temple marked by the gopuram on either side (East and West). The smaller gopuram faces the sacred tank.", "century_desc": "", "noof_sudhais": "", "tower_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby90b3dlcnMvMS8xMi9kb2N1bWVudF8xLmpwZw==" } ] }, { "tower_name": "The west Tower", "settext": "-", "statues_floor": "100", "towerdimensions": "40x100x", "unit_desc": "", "noof_kalasam": "", "protector": "Yes", "tower_desc": "The temple is an emblem of Dravidian style of architecture with giant gopuram (tower). The temple has two entrances. Its fragmentary inscriptions exist since 1250 AD, though the architecture and structure of the temple is more related with the culture that prevailed in 16th century, when Vijay Nagar kings refurbished it.   The notable feature of this structure is the 37-meter tall gopuram, overpowering the street on which the temple sits. As you enter the temple you can see Gnanasambandhars appearance. Other than this, you can see the metal carvings of the 63-Nayanmars", "century_desc": "", "noof_sudhais": "", "tower_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby90b3dlcnMvMS8xL2RvY3VtZW50XzEuanBn" } ] } ], "response_status": "SUCCESS" } ]
    if (dataState is DataFailed) {
      emit(TempleListLodingError(dataState.error!));
    }
  }

  void onGetTempleInfo(GetTempleInfo event, Emitter<ITMSState> emit) async {
    String serviceId = "7009";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "description": "ARULMIGU KAPALEESWARAR TEMPLE, MYLAPORE, CHENNAI- 600004,  \r CHENNAI  DISTRICT.  (TM000001)\r About Temple\r Ptolemy, the Greek Geographer (A.D. 90-168) has referred to Mylapore in his books as Millarpha,. It was apparently a well-known sea port town with a flourishing trade. It must have also been a place of culture, as Saint, Tiruvalluvar the celebrated author of Tirukural, the World-famous ethical treatise, lived in Mylapore nearly 2,000 years ago. The Saivite Saints of the 7th Century, Saint Sambandar and Saint Appear, have sung about the Shrine in their hymns. Mylapore fell into the hands of the Portuguese in A.D.1566, when the temple suffered demolition. The presence temple was rebuilt 300 years ago.\r \r Mayilai  Sri Kapaleeswarar Temple, one of the South Indias most important Saivite worship places in Mylapore, a prime location in the capital city of Tamil Nadu. It attracts many thousands of tourists including foreigners every year. In this temple, the name of the Lord is Sri KAPALEESWARAR. The name of the Goddess is Sri KARPAGAMBAL. It is a lovely temple with a Stately Spire on its eastern side and big tank on its West. The temple and the tank are surrounded by Broad streets on the four sides. The view of the temple and the tank is pictures. Mylapore is on the sea coast and the shore is away by half a mile of thickly populated residential area.", "moolavar_swami_name": "Arulmigu Kapaleeswarar", "moolavar_ambal_name": "Arulmigu Karpagambal", "aagamam_desc": null, "poet_name": "THIRUGNANA SAMBANDHAR", "historical_name": null, "sthala_virutcham": "Punnai Tree", "temple_theertham": "கபாலி தீர்த்தம்", "temple_images": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9hYm91dF90ZW1wbGUvMS8xL2ltYWdlXzEuanBn" } ] } ], "response_status": "SUCCESS" } ]    if (dataState is DataFailed) {
    emit(TempleListLodingError(dataState.error!));
  }

  void onGetTempleTimes(GetTempleTimes event, Emitter<ITMSState> emit) async {
    String serviceId = "7010";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "mrng_openingtime": "05:30 AM", "mrng_closing_time": "12:30 PM", "evng_opening_time": "04:00 PM", "evng_closing_time": "09:30 PM", "remarks": "Only on Mahashivarathiri Temple will  be opened 24 hrs ( 5.00A.M to next day 5.00A.M)", "closing_time": "[{\"to_time\": \"21:30\", \"order_no\": 1, \"from_time\": \"21:15\"}]" } ], "response_status": "SUCCESS" } ]    emit(TempleListLodingError(dataState.error!));
  }

  void onGetTempleLocation(
      GetTempleLocation event, Emitter<ITMSState> emit) async {
    String serviceId = "7011";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "location_desc": "Airport", "location_from": "Chennai International Airport", "distance": "11", "blueprint_image": [], "longitude": "", "latitude": "" }, { "location_desc": "Railway Station", "location_from": "Chennai Central Train Station", "distance": "6", "blueprint_image": [], "longitude": "", "latitude": "" } ], "response_status": "SUCCESS" } ]
  }

  void onGetTempleContacts(
      GetTempleContacts event, Emitter<ITMSState> emit) async {
    String serviceId = "7012";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
//[ { "result_set": [ { "temple_name": "Arulmigu Kapaleeswarar Temple", "temple_doorno": "12/1, North Mada Street", "temple_location": "Mylapore, Chennai", "pincode": "600004", "landline": "044-24641670", "emailid": "jceochn_1[dot]hrce[at]tn[dot]gov[dot]in", "district_name": "Chennai", "temple_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlX2ltYWdlcy8xLzEyOTQ4L2ltYWdlXzEuanBn" } ] } ], "response_status": "SUCCESS" } ]
  }

  void onGetTempleAdmininfo(
      GetTempleAdmininfo event, Emitter<ITMSState> emit) async {
    String serviceId = "7013";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "temple_name": "Arulmigu Kapaleeswarar Temple", "temple_doorno": "12/1", "temple_street": "North Mada Street", "temple_location": "Mylapore, Chennai", "pincode": "600004", "landline": "044-24641670", "email": "jceochn_1[dot]hrce[at]tn[dot]gov[dot]in", "district_name": "Chennai", "username": "P.K.KAVENITHA", "designation_desc": "Joint Commissioner / Exec.officer", "prefix_desc": "Tmt." } ], "response_status": "SUCCESS" } ]
  }

  void onGetTemplePhotogallery(
      GetTemplePhotogallery event, Emitter<ITMSState> emit) async {
    String serviceId = "7014";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
//[ { "result_set": [ { "event_date": "2023-01-09", "title": "QR CODE SCANNER", "description": "Inauguration ceremony for scanning the payment slip of the devotees in the temples admission Q and performing rituals by QR Code Scanner was inaugurated on 09.01.2023 by the Minister of Hindu Religious Charities.", "gallery_desc": "VIP Visits", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTAzMS9pbWFnZV8xLmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTAzMS9pbWFnZV8yLmpwZWc=" } ] }, { "event_date": "2023-01-09", "title": "BOOK STALL INAGURATION FUNCTION", "description": "Spiritual Book Shop was inaugurated on 09.01.2023 by Honble Minister of Hindu Religious Charities.", "gallery_desc": "VIP Visits", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTAzMC9pbWFnZV8xLmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTAzMC9pbWFnZV8yLmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTAzMC9pbWFnZV8zLmpwZWc=" } ] }, { "event_date": "2018-12-08", "title": "AARUDHRA", "description": "Natarajar", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDUvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-10-10", "title": "Navarathiri Festival", "description": "Navaratri\r Navaratri is a festival dedicated to the worship of Goddess Durga. Navaratri means lsquonine nightsrsquo in Sanskrit. The first three days are tamasic, the next three rajasic, and the last three sattvic.The tenth day is referred to as Vijayadashami or Dasera. Navaratri is an important festival and is celebrated all over India. There are in total five types of Navaratri that come in a year. They are Vasantha Navaratri, Ashadha Navaratri, the Sharad Navaratri, the Paush Navaratri and Magha Navathri.Navaratri represents a celebration of Goddess Amba, (the Power).", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfMS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfMi5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfMy5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfNC5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfNS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfNi5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfNy5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfOC5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfOS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzIvaW1hZ2VfMTAuanBn" } ] }, { "event_date": "2018-11-14", "title": "Laksh Deepam", "description": "", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDAvaW1hZ2VfMS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDAvaW1hZ2VfMi5qcGc=" } ] }, { "event_date": "2018-12-10", "title": "KAPALEESWARAR TEMPLE", "description": "Kapaleeswarar Temple View", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDYvaW1hZ2VfMS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDYvaW1hZ2VfMi5qcGc=" } ] }, { "event_date": "2018-12-10", "title": "BARATHANATIYAM", "description": "EVENTS", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDgvaW1hZ2VfMS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDgvaW1hZ2VfMi5qcGc=" } ] }, { "event_date": "2018-10-10", "title": "Tower", "description": "This Rajagopuram is 117 feet tall, and has 3800 dolls depicting different themes. The temple is a testimonial for the Vishwakarma sthapathis. There are seven inlays in this gopuram on all four sides.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMjAvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-11-16", "title": "FLAG POST", "description": "The Sanskrit word for flag is lsquodhvajamrsquo. It means whatever lsquois raisedrsquo. In religious inference that which raises man to a higher level of understanding and activity is lsquodhvajarsquo.  The flag also suggests hope and desire to overcome ignorance. In the top portion of the flag are three horizontal birches/branches pointing towards the Sanctum. It symbolizes righteousness, reputation, and propriety or the Thirumurthis-, Brahma, Vishnu and Siva. The flag post is primarily used to indicate the beginning of a festival or other auspicious days and occasions.  It also depicts human life ends. Flag darishanam enhances kundalini. This is made up of teak, sandalwood, gold coated vertebral column.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDIvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-10-26", "title": "Golden Chariot", "description": "The beautiful golden chariot bedecked with bells , flowers and jewels can be taken out in procession round the temple. It is a divine experience to see the God and Goddess riding in the golden chariot accompanied by devotees. The fee for taking out the golden chariot is Rs.1501/- Those who wish to book the date of procession in advance can send the fee to the office of the temple.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMjEvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-03-11", "title": "Panguni Festival", "description": "Panguni Festival From 11-03-2018 to 20-03-2018\r Saivite saint Sundarar identified the 63 nayanmars.  Sekkizahar wrote the Thiruthondapuranam recounting the life stories of the sixty three Nayanmars. Later in  the 12th century when Cholas ruled, they installed the stone and panchaloka statues of all the saints and their nine servants (adiyar). It was also ordained to perform regular daily pujas and festival for the saints (Nayanars) which is continuing even today in Siva temples. It is worthwhile noting that these saints belong to different regions and different castes (upper and lower). Some of them led a family life, some were sanyasis, and a few women saints. Seven of them contributed to Thirumurai. All of them had immense faith in Shiva.\r All the saints are consecrated in Siva temples. Kapaleeswarar temple is famous and well known for the elaborate, brilliant and fabulous manner in which the 63 saint festival (Arupathu moovar vizha) is celebrated. On the star day of the saints, special Abhishekam is done in the temple.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfMS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfMi5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfMy5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfNC5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfNS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfNi5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfNy5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfOC5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfOS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfMTAuanBn" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfMTEuanBn" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfMTIuanBn" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfMTMuanBn" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzMvaW1hZ2VfMTQuanBn" } ] }, { "event_date": "2018-11-15", "title": "Tank", "description": "Like the Kapali temple, the revered tank has many interesting legendary tales. King of Kalingadesam   had a son called Sambhavan. He committed all atrocities and sins. He came to Kapali temple in the month of Panguni and took a dip in the tank and repented for what he had done and appealed to Kapali for forgiveness. He was forgiven and attained moksha.\r Another tale is  about the temple tank is that it belongs to the Muslim community. It is said that the tank land was owned by the Muslim Fakirs. When they were away, a Brahmin who was a minister with the Nawab ordered a tank to be dug in Mylapore in the land owned by the Fakirs. When the Fakirs returned, they got infuriated. Seeing their anger, the Brahmin told the Nawab that the tank was built for Kapali temple and for the convenience of the travellers and devotees. The Nawab reacted positively and appeased the Fakirs saying that they too could use the tank. Even today, the Prince of Arcot receives the temple honours on the first day of the float festival. Thirtha ustavam or thirtha vari is performed 11 times a year. This is very unique and special as the main deity takes the dip. It is believed that Siva yogis, devotees are invisibly submerged and deity blesses them.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDEvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-11-14", "title": "Arulmigu Kapaleeswarar Swamy", "description": "The sacred shrine of Kapaleeswarar is situated in an area that is 8 meters in length and 6.5 meter wide. The sanctum sanctorium contains the Lingam. At the entrance are the Dwarapalakas  or gate keepers who keep vigil. Traditional oil lamps like the decorative Surya and Chandraprabhai adorn the idol giving a glow and positive energy. The Lingam here is a symbol of the form and formless aspects of the divine. The Lingam is adorned with flowers and bhilva leaves, rudraksha garland and vibhuthi (sacred ash). On special occasions, the peeta (base) will be covered with silver plate and over the Lingam will be the silver hooded snake.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzQvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-11-22", "title": "15 -Vimanams", "description": "There are 15 big and small vimanams for the gods in this temple. Vimanam is a term for the tower above the Garbhagriha or Sanctum Sanctorium in Hindu temple. The Vimanam is more or less star/square shaped plan with salient reentering angles with mouldings, multiplication and colorful striking decorations. Not an inch of space is left uncarved. There are gods, goddesses, angels, animals shown in different layers interspersed with floral and creeper designs and in some cases a huge number of gods and goddesses are shown with lavish decorations and ornaments.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDQvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-12-10", "title": "Arulmigu Kapaleeswarar Swamy& Karpagambal", "description": "Arulmigu Kapaleeswarar with Karpagambal", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvNDcvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-10-10", "title": "Panguni Uthiram Festival", "description": "Panguni Uthiram Festival", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV8xLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV8yLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV8zLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV80LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV81LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV82LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV83LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV84LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV85LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMi9pbWFnZV8xMC5qcGc=" } ] }, { "event_date": "2018-11-14", "title": "Arulmigu Karpagambal", "description": "Karpagambal sannidhi is situated to the north of Kapaleeswarar shrine.  The Amman sannidhi occupies 65 sq. meter area. The deity faces South direction. In front of the goddess, facing her is a stone sculpture of a Lion, the mount of the Goddess. The walls in this Sanndhi are inscribed with Abhirami Andathi, Lalitha Sahasra Naamam, Lalitha Trisadhi. Navarathri festival is held for Karpagambal.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMzUvaW1hZ2VfMS5qcGc=" } ] }, { "event_date": "2018-10-10", "title": "Panguni Uthiram Festival", "description": "Panguni Uthiram Festival \r The temple celebrates a grand brahmotsavam for eleven days followed by a ten day  ldquovedaari vishardquo  celebrations. Pankuni is a month of continous festivals in Kapali temple. The ten day brahmotsavam conducted with precision and perfection. Months ahead of festival , the wooden mounts as well as those plated with silver are polished and painted to give a new look.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8yLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8zLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV80LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV81LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV82LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV83LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV84LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV85LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xMC5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xMS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xMi5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xMy5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xNC5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xNS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xNi5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDE4LzEvMS9pbWFnZV8xNy5qcGc=" } ] }, { "event_date": "2022-09-26", "title": "Navarathri Festival for 2022", "description": "26-9-2022,Navarathri Festival 1st day,Arulmigu Karpagambal  annavaganathil Kolu mandapam                      27-9-2022, Navarathri Festival 2nd day, Arulmigu karpagambal Kamadhenu Vaganathil Alangaram               28-9-2022,Navarathri Festival 3rd day, Arulmigu Karpagambal Saraswathi Alangaram                                   29-9-2022,Navarathri Festival 4th day, Arulmigu Karpagambal Naga vaganathil padmaasini Alangaram             30-9-2022, Navarathri Festival 5thday, ArulmiguKarpagambal Rishab Vaganathil Mageswari Alangaram   1-10-2022,Navarathri Festivals6thday,Arulmigu Karpagambal Rajarajeswarai Alangaram                             2-10-2022,Navarathri Festival 7t day,Arulmigu Karpagambal kuthiray vaganathil meenakshi alangaram   3-10-2022,      Navarathri Festival 8th day Arulmigu Karpagambal Mahishasuramarthini Alangaram     \r 4-10-2022,     Navarathri Festival 9th day, Arulmigu Karpagambal kamakshi siva pooja Alangaram", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV8xLmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV8yLmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV8zLmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV80LmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV81LmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV82LmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV83LmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV84LmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV85LmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDYxMy9pbWFnZV8xMC5qcGc=" } ] }, { "event_date": "2021-03-08", "title": "Panguni Festival For 2022", "description": "Panguni  Festival 1st day Kodiyertam    \r Panguni Festival 2nd day Suryavatam\r Panguni Festival 3rdday Adhigara Nanthi Katchi \r Panguni Festival 4th dayPurusa Merugam Singam,Puli,Vaganagal\r Panguni Festival 5th day Friday Rishab Vagana Katchi  \r Panguni Festival 6th day Elephant Vaganam\r Panguni Festival 7th day Car Festival\r Panguni Festival 8th day 63 Nayanarmagal thiruvidhi ula\r Panguni Festival 9th day  iravalar kola vizha\r Panguni Festival 10th day  Thirukalyanam", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV8xLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV8yLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV80LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV81LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV82LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV84LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV85LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV8xMC5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV8xMS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIxLzEvNDYxNC9pbWFnZV8xMi5qcGVn" } ] }, { "event_date": "2022-10-25", "title": "MAHA KANDHA SASTI", "description": "", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDU0Ni9pbWFnZV8xLmpwZWc=" } ] }, { "event_date": "2022-10-26", "title": "MAHA KANDHA SASTI FESTIVAL", "description": "", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDU0Ny9pbWFnZV8xLmpwZWc=" } ] }, { "event_date": "2022-10-30", "title": "Soorasamharam", "description": "Soorasamharam dated : 30.10.2022", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvNDU0OS9pbWFnZV8xLmpwZWc=" } ] }, { "event_date": "2022-03-15", "title": "PANGUNI FESTIVAL", "description": "KAPALEESWARAR TEMPLE CAR FESTIVAL 2022", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIyLzEvMjcwNy9pbWFnZV8xLmpwZw==" } ] }, { "event_date": "2023-03-28", "title": "Panguni Festival", "description": "2023 Panguni festival was held for 10 days. The first day started with flag hoisting on 28.03.2023 and on 06.04.2023 Panguni festival was held with Swami Ambal Thirukalyanam. In this festival, Athigaranandi, Thiruthear Rishabha Vahanam, Arupathmuvar, Swami Iravalar Kolam and Thirukalyanam were the main ceremonies. Panguni festival was held during the day and night on all ten days of the festival.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV8xLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV8yLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV8zLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV80LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV84LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV85LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV8xMC5qcGVn" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV8xMS5qcGVn" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV8xMi5qcGVn" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTM3NC9pbWFnZV8xMy5qcGc=" } ] }, { "event_date": "2023-02-07", "title": "Theepa Urchavam", "description": "On the third day of February 07, 2023 from 7.00 pm to 11.00 pm, Arulmigu Singaravelar Thirukoil Thirukkulam got up and floated on the raft of Thiruvarul Purivar.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTExNi9pbWFnZV8xLmpwZWc=" } ] }, { "event_date": "2023-01-16", "title": "Kanu Utsavam", "description": "On 16.01.2023 in Kanu Utsavam in this temple, Lord Nandikeshwar will be specially abishegam to Lord Nandikeshwar and will be presented to the devotees in a special decoration with many kinds of sweet and spicy palakaras.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTA3Mi9pbWFnZV8xLmpwZWc=" } ] }, { "event_date": "2023-02-06", "title": "Theepa Urchavam", "description": "2023 February 06 date from 7.00 pm to 10.00 pm On the second day, Lord Singaravelar with the auspicious and strolled in the Thirukulam Theppam Thiruvarul Purivar.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTExMC9pbWFnZV8xLmpwZWc=" } ] }, { "event_date": "2023-02-05", "title": "Theepa Urchavam", "description": "2023 February 05 from 7.00 pm to 10.00 pm On the first day, Lord Kapaleeswarar with the auspicious Karpagambal got up and strolled in the Thirukulam Theppam and Thiruvarul Purivar.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTEwNC9pbWFnZV8xLmpwZWc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTEwNC9pbWFnZV8yLmpwZWc=" } ] }, { "event_date": "2023-02-18", "title": "Mahashivaratri", "description": "Maha Shivaratri Festival 2023 in at Mylapore Arulmigu Kapaleeswarar Temple Sports Ground from 18.02.2023 at 6.00 pm to 19.02.2023 at 6.00 am for 12 hours continuous spiritual and artistic programs.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV8xLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV8yLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV8zLmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV80LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV81LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV82LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV83LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV84LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV85LmpwZw==" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV8xMC5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV8xMS5qcGc=" }, { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxMC9pbWFnZV8xMi5qcGc=" } ] }, { "event_date": "2023-02-18", "title": "Maha Shivarathiri", "description": "Mayilaiyil Maha Shivrathiri Festival 2023 in Mylapore Arulmigu Kapaleeswarar Temple Sports Ground from 18.02.2023 at 6.00 pm to 19.02.2023 at 6.00 am for 12 hours continuous spiritual and artistic performance the scene of the auspicious Kapaleeswarar rising up.", "gallery_desc": "Festivals", "photo_info": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlZ2FsbGVyeS8yMDIzLzEvNTIxNy9pbWFnZV8xLmpwZw==" } ] } ], "response_status": "SUCCESS" } ]
  }

  void onGetTempleVideogallery(
      GetTempleVideogallery event, Emitter<ITMSState> emit) async {
    String serviceId = "7015";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "link_desc": "In the future, the ceremonies held at Arulmiku Kabaleeswarar Temple, Mylapore will be telecasted on the YouTube channel.", "gallery_desc": "Festivals", "video_title": "YouTube channel", "video_url": "https://youtube.com/@MYLAPOREKAPALEESWARARTEMPLE", "content_type": "U", "video_info": [ { "file_location": null } ], "event_date": "11/01/2023" } ], "response_status": "SUCCESS" } ]
  }

  void onGetTempleScrollevent(
      GetTempleScrollevent event, Emitter<ITMSState> emit) async {
    String serviceId = "7016";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "templeid": "TM000001", "temple_id": 1, "temple_name": "Arulmigu Kapaleeswarar Temple, Mylapore, Chennai - 600004", "ttemple_name": "அருள்மிகு கபாலீசுவரர் திருக்கோயில், மயிலாப்பூர், சென்னை - 600004", "event_desc": "Urchavar live", "from_date": "2023-05-17", "to_date": "2024-05-17", "file_info": [], "event_url": "https://www.youtube.com/channel/UCib-68i9VnfVreI0W8kznjg/live", "content_type": "U", "liveurl": "Y", "liveurl_type": "U", "telecast_timing": [ { "to_time": "11:59 PM", "from_time": "12:00 AM" } ], "function_date": "", "published_from": "2023-05-17", "published_upto": "2024-05-17", "maintower_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlX2ltYWdlcy8xLzEyOTQ2L2RvY3VtZW50XzEuanBn" } ] } ], "response_status": "SUCCESS" } ]
  }

  void onGetTempleWhatsnew(
      GetTempleWhatsnew event, Emitter<ITMSState> emit) async {
    String serviceId = "7017";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "dated": "12/10/2022", "title": "test", "description": "temple content", "whatsnew_images": [ { "file_location": "https://hrce.tn.gov.in/demoapp/images/32203.jpg" }, { "file_location": "https://hrce.tn.gov.in/demoapp/images/temple_div.png" } ] } ], "response_status": "SUCCESS" } ]
  }

  void onGetTempleFacility(
      GetTempleFacility event, Emitter<ITMSState> emit) async {
    String serviceId = "7018";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(templeId: event.templeId)])
            .getFormData();
    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Drinking Water R.O.", "facility_location": "Near Arulmiku Anjaneya shrine", "facility_desc": "In this temple, drinking water facility has been set up for the devotees near the shrine of Anjaneya.", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvMjc3L2ltYWdlXzEuanBlZw==" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Free Footwear Stand", "facility_location": "Rajagopuram Opposite", "facility_desc": "n this temple, chappal stand facilities have  available in  outside of the temple this service is free of cost", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvNTY3Mi9pbWFnZV8xLmpwZWc=" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Golden Chariot", "facility_location": "Interior of the temple", "facility_desc": "The golden chariot temple belonging to this temple is in the inner campus security centre. Servants pay a fee of Rs.2500 and carry out a golden chariot procession to fulfill their wishes.", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvNTYwNi9pbWFnZV8xLmpwZWc=" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Hospital", "facility_location": "Near Annadanakutam", "facility_desc": "Siddha medicine is being conducted at this time from 24.10.1975 to date. A free medical service is being offered free of charge by pharmaceuticals. This makes the poor simple people benefit. At the time of the need for drinking water, the service is provided to the devotees.\r \r Note\r From 9.00 am to 12.30 pm\r From 4.00 pm to 7.00 pm\r \r Holiday on Sundays and Government Holidays", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvMjkvaW1hZ2VfMS5qcGc=" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Lactating Mothers Room", "facility_location": "Vinayagar shrine at the back and Utsawar shrine at the back", "facility_desc": "There are 2 rooms behind Vinayagar shrine and 1 room behind Utsawar shrine.", "noof_facilities": "3", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvNzA3My9pbWFnZV8xLmpwZw==" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Library Facility", "facility_location": "Opposite the west tower", "facility_desc": "The spiritual library is opposite the west tower where the oldest books are preserved. This library has 2900 books.", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvMzAvaW1hZ2VfMS5qcGc=" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Marriage Hall", "facility_location": "Near Siddhar Temple", "facility_desc": "The marriage hall belonging to the temple is currently not in use and the process is being taken to start construction at a cost of 19.5 crores.At present, 28 pillars are numbered in the Kandar Anubhuthi Mandapam and Arunagirinath Mandapam in the temple and marriages are conducted.\r Amount for marriage application form-50.\r Amount for marriage-5665.", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvOC9pbWFnZV8xLmpwZw==" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Postal Prasadam", "facility_location": "", "facility_desc": "Delivery of prasadam to devotees through post office.", "noof_facilities": "1", "facility_image": [], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Toilet Facility", "facility_location": "Behind the West Tower", "facility_desc": "The toilet belonging to the temple is not in use at present and the construction work is being started. At present, a mobile toilet has been set up outside the office near Annadhanakoodam.\r It is cleaned twice daily.", "noof_facilities": "20", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvMS9pbWFnZV8xLmpwZWc=" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Tonsure Facility", "facility_location": "Behind the office", "facility_desc": "in this temple hair offering place is currently not used.Construction work is going on. In this temple there is a temprory hair offering place behind the office. There are 2 bathrooms facilities for devotees making hair offerings.", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvNjI2MS9pbWFnZV8xLmpwZWc=" } ], "contact_person": null, "contact_no": "", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Wheel Chair", "facility_location": "Temple Inside", "facility_desc": "The temple is wheelchair accessible. Please refer people at the counter for wheelchair requirements.", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvMjA1L2ltYWdlXzEuanBlZw==" } ], "contact_person": "Raja, Office Assistant", "contact_no": "8072398360", "maintower_image": [] }, { "templeid": "TM000006", "temple_id": 6, "temple_name": "Arulmigu Vadapalani Andavar Temple, Vadapalani, Chennai - 600026", "ttemple_name": "அருள்மிகு வடபழநி ஆண்டவர் திருக்கோயில், வடபழனி, சென்னை - 600026", "facility_title": "Wooden Chariot", "facility_location": "There is the interior of the temple", "facility_desc": "This wooden chariot is located inside the temple near the Arunagirinath shrine. During Vaikasi Visakha, Sevaartis perform their prayers by performing wooden chariot procession.", "noof_facilities": "1", "facility_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlaW5mby9mYWNpbGl0aWVzLzYvNTYwNy9pbWFnZV8xLmpwZWc=" } ], "contact_person": null, "contact_no": "", "maintower_image": [] } ], "response_status": "SUCCESS" } ]
  }

  void onGetTempleList(GetTempleList event, Emitter<ITMSState> emit) async {
    //temple list with 360 view and tower image
    String serviceId = "7019";
    String formData =
        ITMSRequestHandler(serviceId, [FilterData(degree360Avail: "Y")])
            .getFormData();

    final dataState = await _getItmsResponseUseCase(formData, serviceId);

    if (dataState is DataSuccess) {
      if (dataState.responseStatus == "SUCCESS" &&
          dataState.resultSet!.isNotEmpty) {
        emit(TempleListLoaded(dataState.resultSet!));
      } else {
        emit(TempleListLoadingSomthingWentWrong(
            dataState.resultSet![0].responseDesc.toString()));
      }
    }
    //[ { "result_set": [ { "temple_id": 1, "temple_name": "Arulmigu Kapaleeswarar Temple, Mylapore, Chennai - 600004", "ttemple_name": "அருள்மிகு கபாலீசுவரர் திருக்கோயில், மயிலாப்பூர், சென்னை - 600004", "juris_office_code": 216, "district_code": "02", "taluk_code": "08", "village_code": "004", "temple_typecode": 1, "institute_categorycode": 1, "templesection_code": 3, "management_typecode": 1, "management_subtype_code": 1, "degree_360view": "https://mylaikapaleeswarar.hrce.tn.gov.in/resources/docs/virtualtour/1/index.html", "temple_latitude": "13.033842927075", "temple_langitude": "80.269940923909", "maintower_image": [ { "file_location": "aHJjZXBhdGgvdGVtcGxlX2ltYWdlcy8xLzEyOTQ2L2RvY3VtZW50XzEuanBn" } ]}] , "response_status": "SUCCESS" } ]
    if (dataState is DataFailed) {
      emit(TempleListLodingError(dataState.error!));
    }
  }
}
