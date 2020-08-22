// To parse this JSON data, do
//
//     final dyno = dynoFromJson(jsonString);

import 'dart:convert';

class Dyno {
  Dyno({
    this.attachUrl,
    this.command,
    this.createdAt,
    this.id,
    this.name,
    this.app,
    this.release,
    this.size,
    this.state,
    this.type,
    this.updatedAt,
  });

  final dynamic attachUrl;
  final String command;
  final String createdAt;
  final String id;
  final String name;
  final App app;
  final Release release;
  final String size;
  final String state;
  final String type;
  final String updatedAt;

  factory Dyno.fromRawJson(String str) => Dyno.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dyno.fromJson(Map<String, dynamic> json) => Dyno(
        attachUrl: json["attach_url"],
        command: json["command"],
        createdAt: json["created_at"],
        id: json["id"],
        name: json["name"],
        app: App.fromJson(json["app"]),
        release: Release.fromJson(json["release"]),
        size: json["size"],
        state: json["state"],
        type: json["type"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "attach_url": attachUrl,
        "command": command,
        "created_at": createdAt,
        "id": id,
        "name": name,
        "app": app.toJson(),
        "release": release.toJson(),
        "size": size,
        "state": state,
        "type": type,
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

class Release {
  Release({
    this.id,
    this.version,
  });

  final String id;
  final int version;

  factory Release.fromRawJson(String str) => Release.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Release.fromJson(Map<String, dynamic> json) => Release(
        id: json["id"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
      };
}
