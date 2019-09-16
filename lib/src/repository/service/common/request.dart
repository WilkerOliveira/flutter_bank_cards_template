import 'package:bank_cards/src/models/login.dart';
import 'package:dio/dio.dart';

abstract class Request {
  Login login;
  CancelToken cancelToken;
}
