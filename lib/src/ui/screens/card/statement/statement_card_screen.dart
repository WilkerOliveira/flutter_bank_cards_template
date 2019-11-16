import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/repository/card/service/statement/statement_card_response.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/widgets/common/custom_appbar.dart';
import 'package:bank_cards/src/ui/widgets/credit_card/credit_card_front.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/ui/widgets/list_item/statement_item_widget.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/card/statement_card_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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

  Size screenSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
              appBarType: AppBarType.simple, title: S.of(context).app_name)
          .build(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: Decorations.gradientDecoration(),
        ),
        width: this.screenSize.width,
        height: this.screenSize.height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.instance.setHeight(AppDimen.cardsHeight),
              child: Container(
                child: CreditCardFront(),
              ),
            ),
            this.filter(),
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
              height: ScreenUtil.instance.setHeight(AppDimen.filterHeight),
              child: Card(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
                    right: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(S.of(context).statement_date,
                              style: AppStyles.defaultTextStyle()),
                          Padding(
                            padding: EdgeInsets.only(
                              left: ScreenUtil.instance
                                  .setWidth(AppDimen.simpleMargin),
                            ),
                            child: Text(
                              (model.state != ViewState.Busy &&
                                      _statementResponse != null
                                  ? _statementResponse.filterMonth
                                  : " - "),
                              style: AppStyles.defaultTextStyle()
                                  .copyWith(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.blue,
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
                  margin: EdgeInsets.only(
                    top: ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
                    bottom: ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
                  ),
                  alignment: Alignment.centerLeft,
                  child: new ListView.builder(
                    itemCount: _statementResponse.statement.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return StatementItemWidget(
                        icon: _statementResponse.statement[index].icon,
                        title: _statementResponse.statement[index].description,
                        description:
                            _statementResponse.statement[index].additionalInfo,
                        amount: model.toCurrency(
                            _statementResponse.statement[index].amount,
                            _statementResponse.statement[index].type),
                        statementType: _statementResponse.statement[index].type,
                      );
                    },
                  ),
                ),
              )
            : Text(
                "Nothing to show!!!",
                style: AppStyles.defaultTextStyle(),
              )
        : CustomCircularProgressIndicator();
  }
}
