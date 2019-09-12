import 'package:bank_cards/src/models/card/invoice_transactions_card.dart';

import 'package:json_annotation/json_annotation.dart';

part 'invoice_card.g.dart';

@JsonSerializable()
class InvoiceCard {
  String dueDate;
  String typeableLine;
  double currentBalance;

  double minPaymentAmount;
  double amount;

  List<InvoiceTransactionsCard> creditCards;

  InvoiceCard();

  factory InvoiceCard.fromJson(Map<String, dynamic> json) =>
      _$InvoiceCardFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceCardToJson(this);
}
