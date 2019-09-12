import 'package:json_annotation/json_annotation.dart';
import 'package:bank_cards/src/models/card/invoice_card.dart';

part 'invoice_months.g.dart';

@JsonSerializable()
class InvoiceMonths {
  String dueDate;
  String description;

  @JsonKey(ignore: true)
  InvoiceCard invoiceCard;

  InvoiceMonths();

  factory InvoiceMonths.fromJson(Map<String, dynamic> json) =>
      _$InvoiceMonthsFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceMonthsToJson(this);
}
