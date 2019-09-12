import 'package:dio/dio.dart';

abstract class Request {
  String token;
  CancelToken cancelToken;
}
