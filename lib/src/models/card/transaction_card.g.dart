// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionCard _$TransactionCardFromJson(Map<String, dynamic> json) {
  return TransactionCard()
    ..expenseDate = json['expenseDate'] as String
    ..expenseHistory = json['expenseHistory'] as String
    ..amount = (json['amount'] as num)?.toDouble();
}

Map<String, dynamic> _$TransactionCardToJson(TransactionCard instance) =>
    <String, dynamic>{
      'expenseDate': instance.expenseDate,
      'expenseHistory': instance.expenseHistory,
      'amount': instance.amount
    };
