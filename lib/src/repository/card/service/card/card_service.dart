import 'package:bank_cards/src/models/card/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprintf/sprintf.dart';
import 'package:bank_cards/src/repository/card/card_endpoints.dart';
import 'package:bank_cards/src/repository/card/service/card/card_request.dart';
import 'package:bank_cards/src/repository/card/service/card/card_response.dart';
import 'package:bank_cards/src/repository/service/common/rest_client.dart';

class CardService extends RestClient {
  CardService();

  Future<CardResponse> consultCards(CardRequest request) async {
    var response = await getAsync<CardResponse>(
        super.environment.getEndPoint() +
            sprintf(EndPoints.CARDS, [request.token]),
        null,
        request.cancelToken);

    if (response.networkServiceResponse.success) {
      return CardResponse.fromJson(response.mappedResult);
    }

    var error = new CardResponse();
    error.fromErrorJson(response.mappedResult);

    return error;
  }

  Future<QuerySnapshot> consultCardsFB(CardRequest request) async {
    return await super
        .fireStoneReference
        .collection("cards")
        .document("12345678909")
        .collection("data")
        .getDocuments();
  }
}
