// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_transactions_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceTransactionsCard _$InvoiceTransactionsCardFromJson(
    Map<String, dynamic> json) {
  return InvoiceTransactionsCard()
    ..finalCardNumber = json['finalCardNumber'] as String
    ..holderName = json['holderName'] as String
    ..flagHolder = json['flagHolder'] as String
    ..transactions = (json['transactions'] as List)
        ?.map((e) => e == null
            ? null
            : TransactionCard.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$InvoiceTransactionsCardToJson(
        InvoiceTransactionsCard instance) =>
    <String, dynamic>{
      'finalCardNumber': instance.finalCardNumber,
      'holderName': instance.holderName,
      'flagHolder': instance.flagHolder,
      'transactions': instance.transactions
    };
