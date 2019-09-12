import 'package:json_annotation/json_annotation.dart';

part 'transaction_card.g.dart';

@JsonSerializable()
class TransactionCard {
  String expenseDate;
  String expenseHistory;
  double amount;

  @JsonKey(ignore: true)
  String icon;

  TransactionCard();

  factory TransactionCard.fromJson(Map<String, dynamic> json) =>
      _$TransactionCardFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionCardToJson(this);
}
