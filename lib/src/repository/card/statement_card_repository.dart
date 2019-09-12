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
    var header = new Header(false, "default", null, request.token);

    await this._service.setHeader(header);

    return await _service.consultStatement(request);
  }
}
