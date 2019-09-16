import 'package:bank_cards/src/repository/card/service/urls/card_firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sprintf/sprintf.dart';
import 'package:bank_cards/src/repository/card/service/urls/card_endpoints.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_request.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_response.dart';
import 'package:bank_cards/src/repository/card/service/card/card_response.dart';
import 'package:bank_cards/src/repository/service/common/rest_client.dart';

class InvoiceService extends RestClient {
  InvoiceService();

  Future<InvoiceResponse> consultClosedInvoice(InvoiceRequest request) async {
    var response = await getAsync<CardResponse>(
        super.environment.getEndPoint() +
            sprintf(EndPoints.CLOSED_INVOICE, [request.login.token]),
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
                [request.login.token, request.month]),
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
            sprintf(EndPoints.INVOICE_MONTHS, [request.login.token]),
        null,
        request.cancelToken);

    if (response.networkServiceResponse.success) {
      return InvoiceResponse.invoiceMonthsFromJson(response.mappedResult);
    }

    var error = new InvoiceResponse();
    error.fromErrorJson(response.mappedResult);

    return error;
  }

  Future<QuerySnapshot> consultClosedInvoiceFB(InvoiceRequest request) async {
    return await super
        .fireStoneReference
        .collection(CardFireBaseCollections.CARDS_CLOSED_INVOICE)
        .document(request.login.token)
        .collection(request.cardNumber)
        .document(request.month)
        .collection(CardFireBaseCollections.CARDS)
        .getDocuments();
  }
}
