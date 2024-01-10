import 'dart:convert';

class CharFormater {
  static String fromUtf8(String str) {
    var bytes = utf8.encode(str);
    return String.fromCharCodes(bytes);
  }
}