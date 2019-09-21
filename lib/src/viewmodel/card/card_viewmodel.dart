import 'package:bank_cards/src/repository/card/card_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:bank_cards/src/models/card/card.dart';
import 'package:bank_cards/src/repository/card/service/card/card_request.dart';
import 'package:bank_cards/src/repository/card/service/card/card_response.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';

class CardViewModel extends BaseViewModel {
  CardRepository _cardRepository;

  CardViewModel({@required CardRepository repository}) {
    this._cardRepository = repository;
  }

  Future<CardResponse> getCards() async {
    setState(ViewState.Busy);

    try {
      CardRequest request = CardRequest();
      request.login = super.login; //TODO: MOCK

      CardResponse cardsResponse =
          await _cardRepository.consultCardsFB(request);

      if (cardsResponse == null) {
        cardsResponse.cards = List<Card>();
      }

      return cardsResponse;
    } catch (exception, printStackTrace) {
      print(printStackTrace);
      return null;
    } finally {
      setState(ViewState.Idle);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
