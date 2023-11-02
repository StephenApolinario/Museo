import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String aesCrypt(String plainText) {
  final key = Key(Uint8List.fromList(hex.decode(dotenv.get('AES_KEY'))));
  final iv = IV(Uint8List.fromList(hex.decode(dotenv.get('AES_IV'))));
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return encrypted.base16;
}
