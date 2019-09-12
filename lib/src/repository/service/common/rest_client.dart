import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:bank_cards/src/repository/service/api_service.dart';
import 'package:bank_cards/src/repository/service/common/network_service_response.dart';

abstract class RestClient extends APIService {
  RestClient();

  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String endPoint,
      Map<String, dynamic> request, CancelToken cancelToken) async {
    var response = await getClient()
        .get(endPoint, cancelToken: cancelToken, queryParameters: request);

    return _processResponse<T>(response);
  }

  Future<MappedNetworkServiceResponse<T>> postAsync<T>(
      String url, dynamic data, bool shouldEncode) async {
    var content = data;

    if (shouldEncode) content = json.encoder.convert(data);

    var response = await getClient().post(url, data: content);
    return _processResponse<T>(response);
  }

  MappedNetworkServiceResponse<T> _processResponse<T>(Response response) {
    var success = (!((response.statusCode < 200) ||
        (response.statusCode >= 300) ||
        (response.data == null)));

    var jsonResult = jsonEncode(response.data['data']);

    if (jsonResult.startsWith("[{")) {
      jsonResult = '{"data":' + jsonResult + '}';
    }

    Map resultClass = jsonDecode(jsonResult);

    return new MappedNetworkServiceResponse<T>(
        mappedResult: resultClass,
        networkServiceResponse:
            new NetworkServiceResponse<T>(success: success));
  }
}
