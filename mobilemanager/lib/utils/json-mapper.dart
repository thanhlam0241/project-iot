import 'dart:convert';

class JsonMapper<T>{
  static List<T> parseList<T>(String json, T Function(dynamic json) mapFunc){
    var list = <T>[];
    var parsedJson = jsonDecode(json);
    parsedJson.forEach((value){
      list.add(mapFunc(value));
    });
    return list;
  }
}