// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card()
    ..bestBuyDate = json['bestBuyDate'] as int
    ..cardImage = json['cardImage'] as String
    ..cardNumber = json['cardNumber'] as String
    ..dueDate = json['dueDate'] as int
    ..expirationDate = json['expirationDate'] as String
    ..isActive = json['isActive'] as bool
    ..limit = (json['limit'] as num)?.toDouble()
    ..limitAvailable = (json['limitAvailable'] as num)?.toDouble()
    ..limitUsed = (json['limitUsed'] as num)?.toDouble()
    ..nomeOnCard = json['nomeOnCard'] as String;
}

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'bestBuyDate': instance.bestBuyDate,
      'cardImage': instance.cardImage,
      'cardNumber': instance.cardNumber,
      'dueDate': instance.dueDate,
      'expirationDate': instance.expirationDate,
      'isActive': instance.isActive,
      'limit': instance.limit,
      'limitAvailable': instance.limitAvailable,
      'limitUsed': instance.limitUsed,
      'nomeOnCard': instance.nomeOnCard
    };
