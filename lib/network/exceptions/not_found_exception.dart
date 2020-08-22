import 'package:dio/dio.dart';

class NotFoundException implements DioError {
  NotFoundException();
  @override
  String toString() => "request failed, the specified resource does not exist";

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
