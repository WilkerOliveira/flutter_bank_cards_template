import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/card/card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/src/utils/formatter.dart';

class CardDetailWidget extends StatefulWidget {
  final model.Card privateCard;
  final CardViewModel cardViewModel;

  const CardDetailWidget(
      {Key key, @required this.privateCard, this.cardViewModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardDetailWidgetState();
}

class _CardDetailWidgetState extends State<CardDetailWidget> {
  //CardViewModel cardViewModel;

  @override
  void initState() {
    super.initState();

    //this.cardViewModel = Provider.of<CardViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil.instance.setWidth(AppDimen.marginCardDetail),
        right: ScreenUtil.instance.setWidth(AppDimen.marginCardDetail),
      ),
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(
          ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                  child: Text(
                    S.of(context).due_date,
                    style: AppStyles.titleDetailStyle(),
                  ),
                ),
                Selector<CardViewModel, ViewState>(
                  selector: (buildContext, model) => model.state,
                  builder: (context, value, child) => Padding(
                    padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                    child: Text(
                      value != ViewState.Busy && widget.privateCard != null
                          ? widget.privateCard.dueDate.toString()
                          : " - ",
                      style: AppStyles.valueDetailStyle(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: ScreenUtil.instance.setHeight(1),
              color: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                  child: Text(
                    S.of(context).limit,
                    style: AppStyles.titleDetailStyle(),
                  ),
                ),
                Selector<CardViewModel, ViewState>(
                  selector: (buildContext, model) => model.state,
                  builder: (context, value, child) => Padding(
                    padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                    child: Text(
                      value != ViewState.Busy && widget.privateCard != null
                          ? Formatter.moneyFormatter(widget.privateCard.limit)
                          : " - ",
                      style: AppStyles.valueDetailStyle(
                        getAmountColor(widget.privateCard == null
                            ? 0
                            : widget.privateCard.limit),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: ScreenUtil.instance.setHeight(1),
              color: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                  child: Text(
                    S.of(context).available,
                    style: AppStyles.titleDetailStyle(),
                  ),
                ),
                Selector<CardViewModel, ViewState>(
                  selector: (buildContext, model) => model.state,
                  builder: (context, value, child) => Padding(
                    padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                    child: Text(
                      value != ViewState.Busy && widget.privateCard != null
                          ? Formatter.moneyFormatter(
                              widget.privateCard.limitAvailable)
                          : " - ",
                      style: AppStyles.valueDetailStyle(
                        getAmountColor(widget.privateCard == null
                            ? 0
                            : widget.privateCard.limitAvailable),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getAmountColor(amount) {
    return amount <= 0 ? Colors.red : Colors.green;
  }
}
