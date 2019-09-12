import 'package:json_annotation/json_annotation.dart';

part 'statement_card.g.dart';

@JsonSerializable()
class StatementCard {
  String effectiveDate;
  String releaseDate;
  String description;
  double amount;
  String type;
  String additionalInfo;

  String icon;

  StatementCard();

  factory StatementCard.fromJson(Map<String, dynamic> json) =>
      _$StatementCardFromJson(json);

  Map<String, dynamic> toJson() => _$StatementCardToJson(this);
}
