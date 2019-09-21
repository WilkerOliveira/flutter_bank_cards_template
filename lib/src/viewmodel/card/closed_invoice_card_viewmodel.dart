import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:bank_cards/src/repository/card/invoice_card_repository.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_request.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_response.dart';
import 'package:bank_cards/src/utils/constants.dart';
import 'package:bank_cards/src/utils/formatter.dart' as customFormatter;
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';

class ClosedInvoiceCardViewModel extends BaseViewModel {
  InvoiceCardRepository _invoiceCardRepository;
  InvoiceRequest _request;

  ClosedInvoiceCardViewModel({@required InvoiceCardRepository repository}) {
    this._invoiceCardRepository = repository;
  }

  Future<InvoiceResponse> consultClosedInvoice(String dueDate) async {
    setState(ViewState.Busy);

    try {
      this._request = InvoiceRequest();
      this._request.cancelToken = CancelToken();

      this._request.month = dueDate;

      InvoiceResponse result =
          await _invoiceCardRepository.consultClosedInvoice(this._request);

      if (result.success && result.invoiceCard != null) {
        if (result.invoiceCard.creditCards != null) {
          //TODO: must be refactored after backend correction
          result.invoiceCard.creditCards.forEach((item) {
            item.transactions.forEach((itemTransactions) {
              itemTransactions.icon = Constants.STATEMENT_IMAGE_DEBIT;
            });
          });
        }

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
    //TODO: must be refactored to get from String.xml
    var signal = type == Constants.STATEMENT_TYPE_DEBIT ? "- R\$ " : "R\$ ";

    return signal +
        customFormatter.Formatter.toCurrency(value, Intl.defaultLocale);
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
