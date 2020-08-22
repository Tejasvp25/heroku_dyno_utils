import 'package:dio/dio.dart';

class UnauthorizedException implements DioError {
  UnauthorizedException();

  @override
  String toString() =>
      "request not authenticated, API token is missing, invalid or expired";

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
