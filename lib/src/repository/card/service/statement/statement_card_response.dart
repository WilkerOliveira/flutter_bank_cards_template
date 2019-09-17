import 'package:bank_cards/src/models/card/statement_card.dart';
import 'package:bank_cards/src/repository/service/common/response.dart';

class StatementCardResponse extends Response {

  List<StatementCard> statement;

  String filterMonth;

  StatementCardResponse();

  StatementCardResponse.fromJson(Map<String, dynamic> json) :
        statement = (json['transactions'] as List)
            ?.map(
                (e) => e == null ? null : StatementCard.fromJson(e as Map<String, dynamic>))
            ?.toList();

}