import 'package:bank_cards/src/models/card/transaction_card.dart';

import 'package:json_annotation/json_annotation.dart';

part 'invoice_transactions_card.g.dart';

@JsonSerializable()
class InvoiceTransactionsCard {
  String finalCardNumber;
  String holderName;
  String flagHolder;

  List<TransactionCard> transactions;

  InvoiceTransactionsCard();

  factory InvoiceTransactionsCard.fromJson(Map<String, dynamic> json) =>
      _$InvoiceTransactionsCardFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceTransactionsCardToJson(this);
}
