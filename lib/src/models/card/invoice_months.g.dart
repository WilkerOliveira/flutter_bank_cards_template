// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_months.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceMonths _$InvoiceMonthsFromJson(Map<String, dynamic> json) {
  return InvoiceMonths()
    ..dueDate = json['dueDate'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$InvoiceMonthsToJson(InvoiceMonths instance) =>
    <String, dynamic>{
      'dueDate': instance.dueDate,
      'description': instance.description
    };
