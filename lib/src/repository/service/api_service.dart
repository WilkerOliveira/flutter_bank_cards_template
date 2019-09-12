import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:bank_cards/src/config/environment.dart';
import 'package:bank_cards/src/config/environment_config.dart';
import 'package:bank_cards/src/repository/service/common/header.dart';

abstract class APIService {
  Dio _dio;
  Environment _environment;
  final Firestore fireStoneReference = Firestore.instance;

  APIService() {
    _initDio();
    _environment = new EnvironmentConfig().environment;
  }

  ///Configura o DIO
  void _initDio() {
    _dio = new Dio();
  }

  ///Retorna o Environment
  Environment get environment => _environment;

  void _minVersionInterceptor() {}

  void _invalidTokenInterceptor() {}

  void _emptyResponseBodyErrorInterceptor() {}

  /// Retorna a API para comunicação com o Servidor
  Dio getClient() => _dio;

  ///Configura o HEADER da Requisição
  ///
  /// @headerType: Tipo de Header (form-urlencoded, sTransaction, withdraw, deviceId)
  /// @headerInfo: Informação que deve ser preenchida conforme o Header Type
  /// @clientId: Client ID que deve ser utilizado na execução
  Future<bool> setHeader(Header header) async {
    try {
      /// Http request headers.
      var headers = await _getDefaultHeader(header);

      switch (header.type) {
        case "form-urlencoded":
          _dio.options.contentType =
              ContentType.parse("application/x-www-form-urlencoded");

          if (headers.containsKey("X-Device-Info")) {
            headers.update("X-Device-Info", (dynamic val) => header.value);
          } else {
            headers.putIfAbsent("X-Device-Info", () => header.value);
          }

          break;
        case "sTransaction":
          _dio.options.contentType = ContentType.parse("application/json");
          headers.putIfAbsent("S-Transaction", () => header.value);
          break;
        case "withdraw":
          _dio.options.contentType = ContentType.parse("application/json");
          headers.putIfAbsent("X-WithdrawType", () => header.value);
          break;
        case "deviceId":
          _dio.options.contentType = ContentType.parse("application/json");
          headers.putIfAbsent("deviceId", () => header.value);
          break;
        case "internal":
          _dio.options.contentType = ContentType.parse("application/json");
          headers.update(
              "client_id", (dynamic val) => this._environment.getClientId());
          break;
        default:
          _dio.options.contentType = ContentType.parse("application/json");
          break;
      }

      _dio.options.headers = headers;

      return true;
    } catch (exception) {
      print(exception);
      throw Exception(exception);
    }
  }

  Future<Map<String, dynamic>> _getDefaultHeader(Header header) async {
    Map<String, dynamic> headers = Map<String, dynamic>();

    headers.putIfAbsent("client_id", () => this._environment.getClientId());

    //TODO
    headers.putIfAbsent("App-Version", () => "1.0");

    if (header.token != null && header.token.isNotEmpty) {
      headers.putIfAbsent("Authorization", () => "bearer " + header.token);
    }

    return headers;
  }
}
