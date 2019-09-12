import 'package:bank_cards/src/models/card/login.dart';
import 'package:dio/dio.dart';

abstract class Request {
  Login login;
  CancelToken cancelToken;
}
