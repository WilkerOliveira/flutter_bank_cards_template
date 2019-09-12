import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/models/card/statement_card.dart';
import 'package:bank_cards/src/repository/card/service/statement/statement_card_response.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/widgets/common/main_app_header.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/utils/constants.dart';
import 'package:bank_cards/src/viewmodel/base/BaseViewModel.dart';
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
      backgroundColor: Colors.white,
      appBar: mainAppHeader(context),
      body: BaseWidget<StatementCardViewModel>(
        model: StatementCardViewModel(repository: Provider.of(context)),
        onModelReady: (model) async {
          _statementResponse = await model.consultStatement();
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
                  ? _statementResponse != null
                      ? this.statement(model)
                      : Text("Nothing to show!!!")
                  : CustomCircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget statement(model) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.centerLeft,
        child: new ListView.builder(
          itemCount: _statementResponse.statement.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return createItem(_statementResponse.statement[index], model);
          },
        ),
      ),
    );
  }

  Widget createItem(StatementCard statement, model) {
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
            title: Text(statement.description),
            subtitle: Text(statement.additionalInfo),
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
