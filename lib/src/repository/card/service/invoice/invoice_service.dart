import 'package:sprintf/sprintf.dart';
import 'package:bank_cards/src/repository/card/card_endpoints.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_request.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_response.dart';
import 'package:bank_cards/src/repository/card/service/card/card_response.dart';
import 'package:bank_cards/src/repository/service/common/rest_client.dart';

class InvoiceService extends RestClient {
  InvoiceService();

  Future<InvoiceResponse> consultClosedInvoice(InvoiceRequest request) async {
    var response = await getAsync<CardResponse>(
        super.environment.getEndPoint() +
            sprintf(EndPoints.CLOSED_INVOICE, [request.token]),
        null,
        request.cancelToken);

    if (response.networkServiceResponse.success) {
      return InvoiceResponse.fromJson(response.mappedResult);
    }

    var error = new InvoiceResponse();
    error.fromErrorJson(response.mappedResult);

    return error;
  }

  Future<InvoiceResponse> consultClosedInvoiceTransactions(
      InvoiceRequest request, InvoiceResponse invoiceResponse) async {
    var response = await getAsync<CardResponse>(
        super.environment.getEndPoint() +
            sprintf(EndPoints.CLOSED_INVOICE_TRANSACTIONS,
                [request.token, request.month]),
        null,
        request.cancelToken);

    if (response.networkServiceResponse.success) {
      invoiceResponse.transactionsFromJson(response.mappedResult);

      return invoiceResponse;
    }

    var error = new InvoiceResponse();
    error.fromErrorJson(response.mappedResult);

    return error;
  }

  Future<InvoiceResponse> consultInvoiceMonths(InvoiceRequest request) async {
    var response = await getAsync<CardResponse>(
        super.environment.getEndPoint() +
            sprintf(EndPoints.INVOICE_MONTHS, [request.token]),
        null,
        request.cancelToken);

    if (response.networkServiceResponse.success) {
      return InvoiceResponse.invoiceMonthsFromJson(response.mappedResult);
    }

    var error = new InvoiceResponse();
    error.fromErrorJson(response.mappedResult);

    return error;
  }
}
