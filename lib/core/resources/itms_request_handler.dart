import 'package:flutter/cupertino.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '/config/common/class/cryption.dart';
import '/config/common/class/local_storage.dart';
import '/config/common/extensions.dart';
import '/config/constants.dart';
import '/core/models/itms_request.dart';

class ITMSRequestHandler {
  String serviceId;
  dynamic filterData;
  ITMSRequestHandler(
    this.serviceId,
    this.filterData,
  );

  String getFormData() {
    String formData = "";
    debugPrint("AM IN FORM DATA");
    List<Adparam> adparam = [
      Adparam(
          deviceTime: DateTime.now().toStringForm,
          serverTime: DateTime.now().toStringForm)
    ];

    List<Ipaddress> ipAddress = [
      Ipaddress(
          ip: "Prefs.getString(spNetworkIp)!",
          deviceId: '1e7d538a43388eee',
          deviceName: 'PAX A910')
    ];
    String requestTime = DateTime.now().toStringForm;

    List<ITMSRequest> request = [
      ITMSRequest(
          adparam: adparam,
          ipaddress: ipAddress,
          langType: Locales.lang == "en" ? "EN" : "TA",
          serviceId: serviceId,
          filterData: filterData,
          requestTime: requestTime,
          versionDate: ApiCredentials.versionData!,
          versionNumber: spAppVersion,
          requestorUserid: ApiCredentials.requestorUserId,
          requestorUserpwd:
              "13dda615f7495d354a891c6406290db6cd4a443d180bac547208e769e3c18932",
          serviceRequester: ApiCredentials.serviceRequester)
    ];
    debugPrint("Before Encryption: ${request[0].toJson()}");
    formData = Authentication().encrypt(itmsRequestToJson(request));
    debugPrint("encrypted form_data: $formData");
    return formData;
  }
}
