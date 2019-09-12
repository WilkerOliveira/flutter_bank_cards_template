import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class Card {
  int bestBuyDate;
  String cardImage;
  String cardNumber;
  int dueDate;
  String expirationDate;
  bool isActive;
  double limit;
  double limitAvailable;
  double limitUsed;
  String nomeOnCard;

  Card();

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
