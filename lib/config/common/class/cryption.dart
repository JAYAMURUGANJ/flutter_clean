import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

import '../../constants.dart';

class Authentication {
  final key = Key.fromUtf8(ApiCredentials.keyUTF8); //32 chars
  final iv = IV.fromUtf8(ApiCredentials.ivUTF8); //16 chars

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
