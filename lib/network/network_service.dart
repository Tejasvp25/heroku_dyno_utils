import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:heroku_dyno_utils/network/exceptions/forbidden_exception.dart';
import 'package:heroku_dyno_utils/network/exceptions/not_found_exception.dart';
import 'package:heroku_dyno_utils/network/exceptions/rate_limit_exception.dart';
import 'package:heroku_dyno_utils/network/exceptions/unauthorized_exception.dart';
import 'package:heroku_dyno_utils/network/models/config_var.dart';
import 'package:heroku_dyno_utils/network/models/dyno.dart';
import 'package:heroku_dyno_utils/network/models/dyno_formation.dart';
import 'package:heroku_dyno_utils/network/models/herokuapp.dart';

class NetworkService {
  static String authtoken;

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://api.heroku.com/",
      headers: {
        "Accept": "application/vnd.heroku+json; version=3",
        "User-Agent": "PostmanRuntime/7.26.3"
      },
    ),
  )
    ..interceptors.clear()
    ..interceptors.add(CustomInterceptor());

  static void setAuth(String token) {
    authtoken = token;
  }

  static Future<List<HerokuApp>> getApps() async {
    Response<String> res = await dio.get(
      "apps",
      options: Options(headers: {"Authorization": "Bearer $authtoken"}),
    );

    // if (res.statusCode != 200) {
    //   throw Exception(res.statusMessage);
    // }

    return (jsonDecode(res.data) as List)
        .map((e) => HerokuApp.fromJson(e))
        .toList(growable: false);
  }

  static Future<List<Dyno>> getDynos(String appName) async {
    Response<String> res = await dio.get(
      "apps/$appName/dynos",
      options: Options(headers: {"Authorization": "Bearer $authtoken"}),
    );

    // if (res.statusCode != 200) {
    //   throw Exception(res.statusMessage);
    // }
    return (jsonDecode(res.data) as List)
        .map((e) => Dyno.fromJson(e))
        .toList(growable: false);
  }

  static Future<List<ConfigVar>> getConfigVars(String appName) async {
    Response<String> res = await dio.get(
      "apps/$appName/config-vars",
      options: Options(headers: {"Authorization": "Bearer $authtoken"}),
    );

    // if (res.statusCode != 200) {
    //   throw Exception(res.statusMessage);
    // }
    return (jsonDecode(res.data) as Map<String, dynamic>)
        .entries
        .map((e) => ConfigVar(configKey: e.key, value: e.value))
        .toList(growable: false);
  }

  static Future<bool> updateConfigVar(
      String appName, String key, dynamic value) async {
    Response<Map<String, dynamic>> res = await dio.patch(
      "apps/$appName/config-vars",
      options: Options(headers: {"Authorization": "Bearer $authtoken"}),
      data: {key: value},
    );
    // if (res.statusCode != 200) {
    //   throw Exception(res.statusMessage);
    // }
    return res.statusCode == 200;
  }

  static Future<bool> updateDynoStatus(
      String appName, String dynoType, int value) async {
    Response<String> res = await dio.patch(
      "apps/$appName/formation",
      options: Options(headers: {"Authorization": "Bearer $authtoken"}),
      data: {
        "updates": [
          {"quantity": value, "type": dynoType}
        ]
      },
    );
    // if (res.statusCode != 200) {
    //   throw Exception(res.statusMessage);
    // }
    return res.statusCode == 200;
  }

  static Future<List<DynoFormation>> getDynosFormation(String appName) async {
    Response<String> res = await dio.get(
      "apps/$appName/formation",
      options: Options(headers: {"Authorization": "Bearer $authtoken"}),
    );
    // if (res.statusCode != 200) {
    //   throw Exception(res.statusMessage);
    // }
    return (jsonDecode(res.data) as List)
        .map((e) => DynoFormation.fromJson(e))
        .toList(growable: false);
  }
}

class CustomInterceptor extends Interceptor {
  @override
  Future onError(DioError err) async {
    switch (err.response?.statusCode) {
      case 429:
        throw RateLimitException();
        break;
      case 401:
        throw UnauthorizedException();
        break;
      case 403:
        throw ForbiddenException();
        break;
      case 404:
        throw NotFoundException();
        break;
    }
  }
}
