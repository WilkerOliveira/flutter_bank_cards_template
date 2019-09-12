// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceCard _$InvoiceCardFromJson(Map<String, dynamic> json) {
  return InvoiceCard()
    ..dueDate = json['dueDate'] as String
    ..typeableLine = json['typeableLine'] as String
    ..currentBalance = (json['currentBalance'] as num)?.toDouble()
    ..minPaymentAmount = (json['minPaymentAmount'] as num)?.toDouble()
    ..amount = (json['amount'] as num)?.toDouble()
    ..creditCards = (json['creditCards'] as List)
        ?.map((e) => e == null
            ? null
            : InvoiceTransactionsCard.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$InvoiceCardToJson(InvoiceCard instance) =>
    <String, dynamic>{
      'dueDate': instance.dueDate,
      'typeableLine': instance.typeableLine,
      'currentBalance': instance.currentBalance,
      'minPaymentAmount': instance.minPaymentAmount,
      'amount': instance.amount,
      'creditCards': instance.creditCards
    };
