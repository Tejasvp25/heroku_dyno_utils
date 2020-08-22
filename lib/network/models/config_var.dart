// To parse this JSON data, do
//
//     final dyno = dynoFromJson(jsonString);

import 'dart:convert';

class ConfigVar {
  ConfigVar({this.configKey, this.value});

  final String configKey;
  final dynamic value;

  factory ConfigVar.fromRawJson(String str) =>
      ConfigVar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfigVar.fromJson(Map<String, dynamic> json) =>
      ConfigVar(configKey: json.keys.first, value: json.values.first);

  Map<String, dynamic> toJson() => {configKey: value};
}
