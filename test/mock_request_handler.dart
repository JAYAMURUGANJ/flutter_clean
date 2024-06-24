import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:news_app_clean_architecture/config/common/extensions.dart';
import 'package:news_app_clean_architecture/core/models/itms_request.dart';

class MockRequestHandler {
  String serviceId;
  dynamic filterData;
  MockRequestHandler(
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
        langType: "TA",
        serviceId: serviceId,
        filterData: filterData,
        requestTime: requestTime,
        versionDate: "2022-10-10 10:00:00",
        versionNumber: "1.0.0",
        requestorUserid: "hrcevendor1",
        requestorUserpwd:
            "70fd7481af9f82ec81dcaaefebb76010106e28a09f9eeb58afa89eb50119586b",
        serviceRequester: "HRCEVENDR1",
      ),
    ];
    formData = MockAuthentication().encrypt(itmsRequestToJson(request));
    return formData;
  }
}

class MockAuthentication {
  final key = Key.fromUtf8("fWe6qWEJCWb2gcH4+APJL1YmtZmn0NVS"); //32 chars
  final iv = IV.fromUtf8("c1aeB65F17A1c7f3"); //16 chars

// Flutter encryption
  String encrypt(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

// Flutter decryption
  String decrypt(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(text), iv: iv);
    return decrypted;
  }

  String passwordhashing(String uname, String pwd) {
    var encodevalue = "$uname$pwd";
    List<int> bytes = utf8.encode(encodevalue);
    String hash = sha256.convert(bytes).toString();
    return hash;
  }
}
