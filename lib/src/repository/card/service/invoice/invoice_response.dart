import 'package:bank_cards/src/models/card/invoice_card.dart';
import 'package:bank_cards/src/models/card/invoice_months.dart';
import 'package:bank_cards/src/models/card/invoice_transactions_card.dart';
import 'package:bank_cards/src/repository/service/common/response.dart';

class InvoiceResponse extends Response{

  InvoiceCard invoiceCard;
  List<InvoiceMonths> invoiceMonths;

  InvoiceResponse();

  InvoiceResponse.fromJson(Map<String, dynamic> json) :
        invoiceCard = InvoiceCard.fromJson(json);


  void transactionsFromJson(Map<String, dynamic> json) {
        invoiceCard.minPaymentAmount = (json['minPaymentAmount'] as num)?.toDouble();
        invoiceCard.amount = (json['amount'] as num)?.toDouble();
        invoiceCard.creditCards = (json['creditCards'] as List)?.map((e) => e == null
  ? null
      : InvoiceTransactionsCard.fromJson(e as Map<String, dynamic>))
      ?.toList();
    }

  InvoiceResponse.invoiceMonthsFromJson(Map<String, dynamic> json) :
        invoiceMonths =  (json['data'] as List)
            ?.map(
                (e) => e == null ? null : InvoiceMonths.fromJson(e as Map<String, dynamic>))
            ?.toList();

}
