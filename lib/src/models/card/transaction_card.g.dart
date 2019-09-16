// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionCard _$TransactionCardFromJson(Map<String, dynamic> json) {
  return TransactionCard()
    ..id = json['id'] as String
    ..effectiveDate = json['effectiveDate'] as String
    ..releaseDate = json['releaseDate'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..type = json['type'] as String;
}

Map<String, dynamic> _$TransactionCardToJson(TransactionCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'effectiveDate': instance.effectiveDate,
      'releaseDate': instance.releaseDate,
      'amount': instance.amount,
      'type': instance.type
    };
