// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

class Account {
  Account({
    this.allowTracking,
    this.beta,
    this.email,
    this.federated,
    this.id,
    this.identityProvider,
    this.lastLogin,
    this.name,
    this.smsNumber,
    this.twoFactorAuthentication,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.suspendedAt,
    this.defaultOrganization,
    this.defaultTeam,
    this.delinquentAt,
  });

  final bool allowTracking;
  final bool beta;
  final String email;
  final bool federated;
  final String id;
  final dynamic identityProvider;
  final String lastLogin;
  final String name;
  final dynamic smsNumber;
  final bool twoFactorAuthentication;
  final bool verified;
  final String createdAt;
  final String updatedAt;
  final dynamic suspendedAt;
  final dynamic defaultOrganization;
  final dynamic defaultTeam;
  final dynamic delinquentAt;

  factory Account.fromRawJson(String str) => Account.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        allowTracking: json["allow_tracking"],
        beta: json["beta"],
        email: json["email"],
        federated: json["federated"],
        id: json["id"],
        identityProvider: json["identity_provider"],
        lastLogin: json["last_login"],
        name: json["name"],
        smsNumber: json["sms_number"],
        twoFactorAuthentication: json["two_factor_authentication"],
        verified: json["verified"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        suspendedAt: json["suspended_at"],
        defaultOrganization: json["default_organization"],
        defaultTeam: json["default_team"],
        delinquentAt: json["delinquent_at"],
      );

  Map<String, dynamic> toJson() => {
        "allow_tracking": allowTracking,
        "beta": beta,
        "email": email,
        "federated": federated,
        "id": id,
        "identity_provider": identityProvider,
        "last_login": lastLogin,
        "name": name,
        "sms_number": smsNumber,
        "two_factor_authentication": twoFactorAuthentication,
        "verified": verified,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "suspended_at": suspendedAt,
        "default_organization": defaultOrganization,
        "default_team": defaultTeam,
        "delinquent_at": delinquentAt,
      };
}
