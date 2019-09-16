import 'package:json_annotation/json_annotation.dart';

part 'transaction_card.g.dart';

@JsonSerializable()
class TransactionCard {
  String id;
  String effectiveDate;
  String releaseDate;
  double amount;
  String type;

  @JsonKey(ignore: true)
  String icon;

  TransactionCard();

  factory TransactionCard.fromJson(Map<String, dynamic> json) =>
      _$TransactionCardFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionCardToJson(this);
}
