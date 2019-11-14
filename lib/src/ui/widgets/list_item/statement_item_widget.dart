import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatementItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final String amount;
  final String statementType;

  const StatementItemWidget(
      {Key key,
      this.icon,
      this.title,
      this.description,
      this.amount,
      this.statementType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: ScreenUtil.instance.setWidth(AppDimen.defaultDividerHeight),
      ),
      child: Container(
        decoration: Decorations.listItemDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: new Image(
                image: AssetImage(this.icon),
                width: ScreenUtil.instance.setWidth(AppDimen.listItemIconSize),
              ),
              title: Text(
                this.title,
                style: AppStyles.defaultTextStyle(),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
                ),
                child: Text(
                  this.description,
                  style: AppStyles.formTextStyle(
                      Colors.white, AppDimen.defaultLabelSubTitleSize),
                ),
              ),
              trailing: Container(
                alignment: Alignment.center,
                width:
                    ScreenUtil.instance.setWidth(AppDimen.listItemContentWidth),
                height: ScreenUtil.instance
                    .setHeight(AppDimen.listItemContentHeight),
                child: Text(
                  this.amount,
                  style: TextStyle(
                      color: this.statementType == Constants.statementTypeDebit
                          ? AppColor.debitColor
                          : AppColor.green,
                      fontSize:
                          ScreenUtil.instance.setSp(AppDimen.formTextSize),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
