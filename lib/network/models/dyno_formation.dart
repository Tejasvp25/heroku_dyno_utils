// To parse this JSON data, do
//
//     final dynoFormation = dynoFormationFromJson(jsonString);

import 'dart:convert';

class DynoFormation {
  DynoFormation({
    this.app,
    this.command,
    this.createdAt,
    this.id,
    this.type,
    this.quantity,
    this.size,
    this.updatedAt,
  });

  final App app;
  final String command;
  final String createdAt;
  final String id;
  final String type;
  final int quantity;
  final String size;
  final String updatedAt;

  factory DynoFormation.fromRawJson(String str) =>
      DynoFormation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DynoFormation.fromJson(Map<String, dynamic> json) => DynoFormation(
        app: App.fromJson(json["app"]),
        command: json["command"],
        createdAt: json["created_at"],
        id: json["id"],
        type: json["type"],
        quantity: json["quantity"],
        size: json["size"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "app": app.toJson(),
        "command": command,
        "created_at": createdAt,
        "id": id,
        "type": type,
        "quantity": quantity,
        "size": size,
        "updated_at": updatedAt,
      };
}

class App {
  App({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  factory App.fromRawJson(String str) => App.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory App.fromJson(Map<String, dynamic> json) => App(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
