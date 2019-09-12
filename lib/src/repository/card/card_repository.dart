import 'package:bank_cards/src/models/card/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:bank_cards/src/repository/card/service/card/card_request.dart';
import 'package:bank_cards/src/repository/card/service/card/card_response.dart';
import 'package:bank_cards/src/repository/card/service/card/card_service.dart';
import 'package:bank_cards/src/repository/service/common/header.dart';

class CardRepository {
  CardService _service;

  CardRepository({@required CardService service}) {
    this._service = service;
  }

  Future<CardResponse> consultCards(CardRequest request) async {
    var header = new Header(false, "default", null, request.login.token);

    await this._service.setHeader(header);

    return await _service.consultCards(request);
  }

  Future<CardResponse> consultCardsFB(CardRequest request) async {
    QuerySnapshot querySnapshot = await _service.consultCardsFB(request);
    CardResponse cardResponse = CardResponse();
    cardResponse.cards = List<Card>();
    cardResponse.success = false;

    if (querySnapshot != null && querySnapshot.documents != null) {
      for (DocumentSnapshot document in querySnapshot.documents) {
        cardResponse.cards.add(Card.fromJson(document.data));
      }
      cardResponse.success = true;
    }

    return cardResponse;
  }
}
