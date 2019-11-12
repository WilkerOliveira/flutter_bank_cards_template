import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/widgets/common/common_widgets.dart';
import 'package:bank_cards/src/ui/widgets/credit_card/credit_card_front.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/repository/card/service/statement/statement_card_response.dart';
import 'package:bank_cards/src/ui/widgets/common/custom_appbar.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/card/statement_card_viewmodel.dart';

class StatementCardScreen extends StatefulWidget {
  final model.Card _privateCard;
  StatementCardScreen(this._privateCard);

  @override
  _StatementCardScreenState createState() =>
      _StatementCardScreenState(this._privateCard);
}

class _StatementCardScreenState extends State<StatementCardScreen> {
  StatementCardResponse _statementResponse;

  model.Card _privateCard;

  _StatementCardScreenState(this._privateCard);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              appBarType: AppBarType.simple, title: S.of(context).app_name)
          .build(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: Decorations.gradientDecoration(),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 230.0,
              child: Container(
                padding: EdgeInsets.all(10),
                child: CreditCardFront(),
              ),
            ),
            this.filter(),
            //this.statement(),
          ],
        ),
      ),
    );
  }

  Widget filter() {
    return BaseWidget<StatementCardViewModel>(
      model: StatementCardViewModel(repository: Provider.of(context)),
      onModelReady: (model) async {
        _statementResponse = await model.consultStatement();
      },
      builder: (mainContext, model, child) => Expanded(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              child: Card(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Statement date: "),
                          Text(
                            (model.state != ViewState.Busy
                                ? _statementResponse.filterMonth
                                : " - "),
                            style: TextStyle(
                              color: AppColor.green,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.filter_list,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            this.statement(model),
          ],
        ),
      ),
    );
  }

  Widget statement(model) {
    return model.state != ViewState.Busy
        ? _statementResponse != null
            ? Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: new ListView.builder(
                    itemCount: _statementResponse.statement.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return CommonWidgets.createInvoiceItem(
                          _statementResponse.statement[index], model);
                    },
                  ),
                ),
              )
            : Text("Nothing to show!!!")
        : CustomCircularProgressIndicator();
  }
}
