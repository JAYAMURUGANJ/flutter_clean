import 'dart:developer';

import 'package:flutter_locales/flutter_locales.dart';

import '../../config/common/class/local_storage.dart';
import '/config/common/class/cryption.dart';
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
    List<Adparam> adparam = [
      Adparam(
          deviceTime: DateTime.now().toStringForm,
          serverTime: DateTime.now().toStringForm)
    ];

    List<Ipaddress> ipAddress = [
      Ipaddress(
          ip: "192.168.224.50",
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
        requestorUserpwd: ApiCredentials.requestorUserPwd!,
        serviceRequester: ApiCredentials.serviceRequester,
      ),
    ];

    log(request[0].toJson().toString(), name: "Before Encrypt Form Data");
    formData = Authentication().encrypt(itmsRequestToJson(request));
    log(formData.toString(), name: "After Encrypt Form Data");
    return formData;
  }
}
