import 'package:bank_cards/src/models/card/statement_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_request.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_response.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_service.dart';
import 'package:bank_cards/src/repository/service/common/header.dart';

class StatementCardRepository {
  StatementCardService _service;

  StatementCardRepository({@required StatementCardService service}) {
    this._service = service;
  }

  Future<StatementCardResponse> consultStatement(
      StatementCardRequest request) async {
    var header = new Header(false, "default", null, request.login.token);

    await this._service.setHeader(header);

    return await _service.consultStatement(request);
  }

  Future<StatementCardResponse> consultStatementFB(StatementCardRequest request) async {

    QuerySnapshot querySnapshot = await _service.consultStatementFB(request);

    StatementCardResponse cardResponse = StatementCardResponse();
    cardResponse.statement = List<StatementCard>();
    cardResponse.success = false;

    if (querySnapshot != null && querySnapshot.documents != null) {

      for (DocumentSnapshot document in querySnapshot.documents) {

        cardResponse.statement.add(StatementCard.fromJson(document.data));

      }

      cardResponse.success = true;
    }

    return cardResponse;
  }
}
