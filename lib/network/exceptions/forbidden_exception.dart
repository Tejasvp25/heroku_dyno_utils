import 'package:dio/dio.dart';

class ForbiddenException implements DioError {
  ForbiddenException();
  @override
  String toString() =>
      "request not authorized, provided credentials do not provide access to specified resource";

  @override
  var error;

  @override
  RequestOptions request;

  @override
  Response response;

  @override
  DioErrorType type = DioErrorType.RESPONSE;

  @override
  String get message => toString();
}
