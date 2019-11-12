import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/src/models/card/card_dto.dart';
import 'package:bank_cards/src/models/card/invoice_months.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/repository/card/service/invoice/invoice_response.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/ui/widgets/common/custom_appbar.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/utils/formatter.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/card/invoice_card_viewmodel.dart';

class InvoiceCardScreen extends StatefulWidget {
  final model.Card _privateCard;
  InvoiceCardScreen(this._privateCard);

  @override
  _InvoiceCardScreenState createState() =>
      _InvoiceCardScreenState(this._privateCard);
}

class _InvoiceCardScreenState extends State<InvoiceCardScreen> {
  InvoiceResponse _invoiceResponse;

  model.Card _privateCard;

  _InvoiceCardScreenState(this._privateCard);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(appBarType: AppBarType.simple , title: S.of(context).app_name).build(context),
      body: BaseWidget<InvoiceCardViewModel>(
        model: InvoiceCardViewModel(repository: Provider.of(context)),
        onModelReady: (model) async {
          this._invoiceResponse = await model.consultInvoiceMonths();
        },
        builder: (mainContext, model, child) => new Container(
          child: model.state != ViewState.Busy
              ? new ListView.builder(
                  itemCount: this._invoiceResponse.invoiceMonths.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return createItem(
                        this._invoiceResponse.invoiceMonths[index]);
                  },
                )
              : Center(
                  child: CustomCircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Widget createItem(InvoiceMonths invoiceMonths) {
    return GestureDetector(
      onTap: () {
        var cardDto = CardDto();
        cardDto.privateCard = _privateCard;
        cardDto.extraInfo = invoiceMonths.dueDate;

        Navigator.pushNamed(context, Router.CARD_CLOSED_INVOICE,
            arguments: cardDto);
      },
      child: Card(
        color: AppColor.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              title: Text(invoiceMonths.dueDate.toString()),
              subtitle: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text("Amount: " +
                        Formatter.toCurrency(
                            invoiceMonths.invoiceCard == null
                                ? 0
                                : invoiceMonths.invoiceCard.amount,
                            Intl.defaultLocale)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
