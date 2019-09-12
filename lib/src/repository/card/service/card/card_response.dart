import 'package:bank_cards/src/models/card/card.dart';
import 'package:bank_cards/src/repository/service/common/response.dart';

class CardResponse extends Response {
  List<Card> cards;

  CardResponse();

  CardResponse.fromJson(Map<String, dynamic> json)
      : cards = (json['data'] as List)
            ?.map((e) =>
                e == null ? null : Card.fromJson(e as Map<String, dynamic>))
            ?.toList();
}
