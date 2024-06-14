abstract class ITMSEvent {
  const ITMSEvent();
}

class GetTempleList extends ITMSEvent {
  String seniorgradeTemples;
  GetTempleList({
    required this.seniorgradeTemples,
  });
}

class GetTempleHistory extends ITMSEvent {
  String templeId;
  GetTempleHistory({
    required this.templeId,
  });
}

class GetTempleSpecialty extends ITMSEvent {
  String templeId;
  GetTempleSpecialty({
    required this.templeId,
  });
}

class GetTemplePooja extends ITMSEvent {
  String templeId;
  GetTemplePooja({
    required this.templeId,
  });
}

class GetTempleTowers extends ITMSEvent {
  String templeId;
  GetTempleTowers({
    required this.templeId,
  });
}

class GetTempleInfo extends ITMSEvent {
  String templeId;
  GetTempleInfo({
    required this.templeId,
  });
}

class GetTempleTimes extends ITMSEvent {
  String templeId;
  GetTempleTimes({
    required this.templeId,
  });
}

class GetTempleLocation extends ITMSEvent {
  String templeId;
  GetTempleLocation({
    required this.templeId,
  });
}

class GetTempleContacts extends ITMSEvent {
  String templeId;
  GetTempleContacts({
    required this.templeId,
  });
}

class GetTempleAdmininfo extends ITMSEvent {
  String templeId;
  GetTempleAdmininfo({
    required this.templeId,
  });
}

class GetTemplePhotogallery extends ITMSEvent {
  String templeId;
  GetTemplePhotogallery({
    required this.templeId,
  });
}

class GetTempleVideogallery extends ITMSEvent {
  String templeId;
  GetTempleVideogallery({
    required this.templeId,
  });
}

class GetTempleScrollevent extends ITMSEvent {
  String templeId;
  GetTempleScrollevent({
    required this.templeId,
  });
}

class GetTempleWhatsnew extends ITMSEvent {
  String templeId;
  GetTempleWhatsnew({
    required this.templeId,
  });
}

class GetTempleFacility extends ITMSEvent {
  String templeId;
  GetTempleFacility({
    required this.templeId,
  });
}

class FilterTempleList extends ITMSEvent {
  final String value;
  FilterTempleList(this.value);
}

class FilterTempleListByWorship extends ITMSEvent {
  final int worshipCode;
  FilterTempleListByWorship(this.worshipCode);
}
