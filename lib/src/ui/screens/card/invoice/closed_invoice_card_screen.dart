import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/src/models/card/card_dto.dart';
import 'package:bank_cards/src/models/card/invoice_transactions_card.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/models/card/transaction_card.dart';
import 'package:bank_cards/src/repository/card/service/invoice/invoice_response.dart';
import 'file:///Users/wilkeroliveira/Documents/Projects/FlutterProjects/lnl/lib/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/widgets/common/main_app_header.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/utils/constants.dart';
import 'package:bank_cards/src/utils/formatter.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/card/closed_invoice_card_viewmodel.dart';

class ClosedInvoiceCardScreen extends StatefulWidget {
  final CardDto _cardDto;
  ClosedInvoiceCardScreen(this._cardDto);

  @override
  _ClosedInvoiceCardScreenState createState() =>
      _ClosedInvoiceCardScreenState(this._cardDto);
}

class _ClosedInvoiceCardScreenState extends State<ClosedInvoiceCardScreen> {
  InvoiceResponse _invoiceResponse;
  CardDto _cardDto;
  model.Card _privateCard;
  String dueDate;

  _ClosedInvoiceCardScreenState(this._cardDto);

  @override
  void initState() {
    super.initState();

    _privateCard = _cardDto.privateCard;
    dueDate = _cardDto.extraInfo.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppHeader(context),
      body: BaseWidget<ClosedInvoiceCardViewModel>(
        model: ClosedInvoiceCardViewModel(repository: Provider.of(context)),
        onModelReady: (model) async {
          _invoiceResponse = await model.consultClosedInvoice(this.dueDate);
        },
        builder: (mainContext, model, child) => new Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 230.0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: new Image.network(
                    _privateCard.cardImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              model.state != ViewState.Busy
                  ? _invoiceResponse != null &&
                          _invoiceResponse.invoiceCard != null
                      ? Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Due Date: " +
                                        _invoiceResponse.invoiceCard.dueDate
                                            .toString(),
                                  ),
                                  Text("Amount: " +
                                      Formatter.toCurrency(
                                          _invoiceResponse.invoiceCard.amount,
                                          Intl.defaultLocale)),
                                  Text("Barcode: " +
                                      _invoiceResponse
                                          .invoiceCard.typeableLine),
                                ],
                              ),
                            ),
                            _invoiceResponse != null &&
                                    _invoiceResponse.invoiceCard != null &&
                                    _invoiceResponse.invoiceCard.creditCards !=
                                        null
                                ? this.invoiceTransactions(model)
                                : Text("Nothing to show!!!")
                          ],
                        )
                      : Text("Nothing to show!!!")
                  : CustomCircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget invoiceTransactions(ClosedInvoiceCardViewModel model) {
    return Column(
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: _invoiceResponse.invoiceCard.creditCards.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return createCardItem(
                _invoiceResponse.invoiceCard.creditCards[index], model);
          },
        ),
      ],
    );
  }

  Widget createCardItem(InvoiceTransactionsCard invoiceTransactionsCard,
      ClosedInvoiceCardViewModel model) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Final number " + invoiceTransactionsCard.finalCardNumber),
              Text(" - "),
              Text(invoiceTransactionsCard.holderName),
            ],
          ),
          new ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: invoiceTransactionsCard.transactions.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return createItem(
                  invoiceTransactionsCard.transactions[index], model);
            },
          ),
        ],
      ),
    );
  }

  Widget createItem(
      TransactionCard statement, ClosedInvoiceCardViewModel model) {
    return Card(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            leading: new Image(
              image: AssetImage(statement.icon),
              width: 36,
            ),
            title: Text(statement.effectiveDate),
            subtitle: Text(statement.effectiveDate),
            trailing: Container(
              alignment: Alignment.center,
              width: 100,
              height: 40,
              child: Text(
                model.toCurrency(
                    statement.amount, Constants.STATEMENT_TYPE_DEBIT),
                style: TextStyle(
                    color: Color(0xFFB34747),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
