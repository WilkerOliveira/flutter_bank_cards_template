import 'package:sprintf/sprintf.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_request.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_response.dart';
import 'package:bank_cards/src/repository/service/common/rest_client.dart';

import 'package:bank_cards/src/repository/card/card_endpoints.dart';

class StatementCardService extends RestClient {
  StatementCardService();

  Future<StatementCardResponse> consultStatement(
      StatementCardRequest request) async {
    var response = await getAsync<StatementCardResponse>(
        super.environment.getEndPoint() +
            sprintf(EndPoints.STATEMENT_CARD, [request.login.token]),
        null,
        request.cancelToken);

    if (response.networkServiceResponse.success) {
      return StatementCardResponse.fromJson(response.mappedResult);
    }

    var error = new StatementCardResponse();
    error.fromErrorJson(response.mappedResult);

    return error;
  }
}
