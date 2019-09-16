import 'package:bank_cards/src/repository/card/service/urls/card_firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprintf/sprintf.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_request.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_response.dart';
import 'package:bank_cards/src/repository/service/common/rest_client.dart';

import 'package:bank_cards/src/repository/card/service/urls/card_endpoints.dart';

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

  Future<QuerySnapshot> consultStatementFB(StatementCardRequest request) async {
    return await super
        .fireStoneReference
        .collection(CardFireBaseCollections.CARDS_TRANSACTIONS)
        .document(request.login.token)
        .collection(request.cardNumber)
        .document(request.month)
        .collection(CardFireBaseCollections.DATA)
        .getDocuments();
  }
}
