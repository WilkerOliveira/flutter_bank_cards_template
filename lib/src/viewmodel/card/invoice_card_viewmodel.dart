import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:bank_cards/src/repository/card/invoice_card_repository.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_request.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_response.dart';
import 'package:bank_cards/src/utils/constants.dart';
import 'package:bank_cards/src/utils/formatter.dart' as customFormatter;
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';

class InvoiceCardViewModel extends BaseViewModel {
  InvoiceCardRepository _invoiceCardRepository;
  InvoiceRequest _request;

  InvoiceCardViewModel({@required InvoiceCardRepository repository}) {
    this._invoiceCardRepository = repository;
  }

  Future<InvoiceResponse> consultInvoiceMonths() async {
    setState(ViewState.Busy);

    try {
      this._request = InvoiceRequest();
      this._request.cancelToken = CancelToken();

      InvoiceResponse invoiceResponse =
          await _invoiceCardRepository.consultInvoiceMonths(this._request);

      if (invoiceResponse.success && invoiceResponse.invoiceMonths != null) {
        //TODO: must be refactored after backend correction
        for (var item in invoiceResponse.invoiceMonths) {
          this._request.month = item.dueDate.toString();

          item.invoiceCard = (await this
                  ._invoiceCardRepository
                  .consultClosedInvoiceTransactions(this._request))
              .invoiceCard;
        }
      }

      return invoiceResponse;
    } catch (exception, printStackTrace) {
      print(printStackTrace);
      return null;
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
