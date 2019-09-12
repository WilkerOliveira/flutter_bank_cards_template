import 'package:flutter/foundation.dart';
import 'package:bank_cards/src/models/card/invoice_card.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_request.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_response.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_service.dart';
import 'package:bank_cards/src/repository/service/common/header.dart';

class InvoiceCardRepository {
  InvoiceService _service;

  InvoiceCardRepository({@required InvoiceService service}) {
    this._service = service;
  }

  Future<InvoiceResponse> consultClosedInvoice(InvoiceRequest request) async {
    var header = new Header(false, "default", null, request.login.token);

    await this._service.setHeader(header);

    var invoiceResponse = await _service.consultClosedInvoice(request);

    if (invoiceResponse.success) {
      return await _service.consultClosedInvoiceTransactions(
          request, invoiceResponse);
    }

    return invoiceResponse;
  }

  Future<InvoiceResponse> consultInvoiceMonths(InvoiceRequest request) async {
    var header = new Header(false, "default", null, request.login.token);

    await this._service.setHeader(header);

    return await _service.consultInvoiceMonths(request);
  }

  Future<InvoiceResponse> consultClosedInvoiceTransactions(
      InvoiceRequest request) async {
    var header = new Header(false, "default", null, request.login.token);

    await this._service.setHeader(header);

    var invoiceResponse = InvoiceResponse();
    invoiceResponse.invoiceCard = InvoiceCard();

    return await _service.consultClosedInvoiceTransactions(
        request, invoiceResponse);
  }
}
