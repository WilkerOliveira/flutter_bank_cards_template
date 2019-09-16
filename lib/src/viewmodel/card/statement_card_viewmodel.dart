import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_request.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_response.dart';
import 'package:bank_cards/src/repository/card/statement_card_repository.dart';
import 'package:bank_cards/src/utils/constants.dart';
import 'package:bank_cards/src/utils/formatter.dart';
import 'package:bank_cards/src/viewmodel/base/BaseViewModel.dart';

class StatementCardViewModel extends BaseViewModel {
  StatementCardRepository _statementCardRepository;
  StatementCardRequest _request;

  StatementCardViewModel({@required StatementCardRepository repository}) {
    this._statementCardRepository = repository;
  }

  Future<StatementCardResponse> consultStatement() async {
    setState(ViewState.Busy);

    try {
      //TODO
      this._request = StatementCardRequest();
      this._request.cancelToken = CancelToken();
      this._request.month = "2019-07";
      this._request.cardNumber = "5101685003780116";
      this._request.login = super.login;

      StatementCardResponse result =
          await _statementCardRepository.consultStatementFB(this._request);

      if (result.success &&
          result.statement != null &&
          result.statement.isNotEmpty) {
        //TODO: must be refactored after backend correction
        result.statement.forEach((item) {
          item.icon = item.type == "D" ? Constants.STATEMENT_IMAGE_DEBIT : Constants.STATEMENT_IMAGE_CREDIT;
          item.additionalInfo = this.toDateString(item.effectiveDate);
        });

        return result;
      }

      return null;
    } catch (exception, printStackTrace) {
      if (CancelToken.isCancel(exception)) {
        return null;
      } else {
        print(printStackTrace);
        return null;
      }
    } finally {
      setState(ViewState.Idle);
    }
  }

  String toCurrency(double value, String type) {

    var signal = type == Constants.STATEMENT_TYPE_DEBIT ? "- " : " ";

    return signal + Formatter.toCurrency(value, Intl.defaultLocale);
  }

  String toDateString(String date) {
    var formatter = new DateFormat('dd/MM/yy HH:mm:ss');
    return formatter.format(DateTime.parse(date));
  }

  @override
  void dispose() {
    if (this._request != null) {
      this._request.cancelToken.cancel("cancel");
    }
    super.dispose();
  }
}
