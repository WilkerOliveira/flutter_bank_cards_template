// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatementCard _$StatementCardFromJson(Map<String, dynamic> json) {
  return StatementCard()
    ..effectiveDate = json['effectiveDate'] as String
    ..releaseDate = json['releaseDate'] as String
    ..description = json['description'] as String
    ..amount = (json['amount'] as num)?.toDouble()
    ..type = json['type'] as String
    ..additionalInfo = json['additionalInfo'] as String
    ..icon = json['icon'] as String;
}

Map<String, dynamic> _$StatementCardToJson(StatementCard instance) =>
    <String, dynamic>{
      'effectiveDate': instance.effectiveDate,
      'releaseDate': instance.releaseDate,
      'description': instance.description,
      'amount': instance.amount,
      'type': instance.type,
      'additionalInfo': instance.additionalInfo,
      'icon': instance.icon
    };
