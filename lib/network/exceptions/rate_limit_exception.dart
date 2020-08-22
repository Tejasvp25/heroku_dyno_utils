import 'package:dio/dio.dart';

class RateLimitException implements DioError {
  RateLimitException();

  @override
  String toString() =>
      "Your account reached the API rate limit\nPlease wait a few minutes before making new requests";

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
