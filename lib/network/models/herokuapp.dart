import 'dart:convert';

class HerokuApp {
  HerokuApp({
    this.acm,
    this.archivedAt,
    this.buildpackProvidedDescription,
    this.buildStack,
    this.createdAt,
    this.id,
    this.gitUrl,
    this.maintenance,
    this.name,
    this.owner,
    this.region,
    this.organization,
    this.team,
    this.space,
    this.internalRouting,
    this.releasedAt,
    this.repoSize,
    this.slugSize,
    this.stack,
    this.updatedAt,
    this.webUrl,
  });

  final bool acm;
  final dynamic archivedAt;
  final String buildpackProvidedDescription;
  final BuildStack buildStack;
  final String createdAt;
  final String id;
  final String gitUrl;
  final bool maintenance;
  final String name;
  final Owner owner;
  final BuildStack region;
  final dynamic organization;
  final dynamic team;
  final dynamic space;
  final dynamic internalRouting;
  final String releasedAt;
  final int repoSize;
  final int slugSize;
  final BuildStack stack;
  final String updatedAt;
  final String webUrl;

  factory HerokuApp.fromRawJson(String str) =>
      HerokuApp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HerokuApp.fromJson(Map<String, dynamic> json) => HerokuApp(
        acm: json["acm"],
        archivedAt: json["archived_at"],
        buildpackProvidedDescription:
            json["buildpack_provided_description"] == null
                ? null
                : json["buildpack_provided_description"],
        buildStack: BuildStack.fromJson(json["build_stack"]),
        createdAt: json["created_at"],
        id: json["id"],
        gitUrl: json["git_url"],
        maintenance: json["maintenance"],
        name: json["name"],
        owner: Owner.fromJson(json["owner"]),
        region: BuildStack.fromJson(json["region"]),
        organization: json["organization"],
        team: json["team"],
        space: json["space"],
        internalRouting: json["internal_routing"],
        releasedAt: json["released_at"],
        repoSize: json["repo_size"] == null ? null : json["repo_size"],
        slugSize: json["slug_size"] == null ? null : json["slug_size"],
        stack: BuildStack.fromJson(json["stack"]),
        updatedAt: json["updated_at"],
        webUrl: json["web_url"],
      );

  Map<String, dynamic> toJson() => {
        "acm": acm,
        "archived_at": archivedAt,
        "buildpack_provided_description": buildpackProvidedDescription == null
            ? null
            : buildpackProvidedDescription,
        "build_stack": buildStack.toJson(),
        "created_at": createdAt,
        "id": id,
        "git_url": gitUrl,
        "maintenance": maintenance,
        "name": name,
        "owner": owner.toJson(),
        "region": region.toJson(),
        "organization": organization,
        "team": team,
        "space": space,
        "internal_routing": internalRouting,
        "released_at": releasedAt,
        "repo_size": repoSize == null ? null : repoSize,
        "slug_size": slugSize == null ? null : slugSize,
        "stack": stack.toJson(),
        "updated_at": updatedAt,
        "web_url": webUrl,
      };
}

class BuildStack {
  BuildStack({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  factory BuildStack.fromRawJson(String str) =>
      BuildStack.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BuildStack.fromJson(Map<String, dynamic> json) => BuildStack(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Owner {
  Owner({
    this.email,
    this.id,
  });

  final String email;
  final String id;

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
      };
}
