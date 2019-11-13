import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/utils/constants.dart';
import 'package:bank_cards/src/utils/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonWidgets {
  static BoxDecoration loginBackground() {
    return BoxDecoration(
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.0, 0.5, 1.0],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Converter.hexToColor('#004a91'),
          Converter.hexToColor('#187adf'),
          Converter.hexToColor('#00b9f8'),
        ],
      ),
    );
  }

  static Widget separator() {
    return Text(
      "|",
      style: TextStyle(
        fontSize: 30,
      ),
    );
  }

  static Widget menuItem(img, text) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 90,
      width: 112,
      decoration: new BoxDecoration(
        border: new Border.all(color: AppColor.green),
        borderRadius: new BorderRadius.only(
          bottomLeft: const Radius.circular(15.0),
          bottomRight: const Radius.circular(15.0),
          topRight: const Radius.circular(15.0),
          topLeft: const Radius.circular(15.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(img, width: 48),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget createInvoiceItem(statement, model) {
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
                image: AssetImage(statement.icon),
                width: 36,
              ),
              title: Text(
                statement.description,
                style: AppStyles.defaultTextStyle(),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: AppDimen.simpleMargin),
                child: Text(
                  statement.additionalInfo,
                  style: AppStyles.formTextStyle(
                      Colors.white, AppDimen.defaultLabelSubTitleSize),
                ),
              ),
              trailing: Container(
                alignment: Alignment.center,
                width: 100,
                height: 40,
                child: Text(
                  model.toCurrency(statement.amount, statement.type),
                  style: TextStyle(
                      color: statement.type == Constants.statementTypeDebit
                          ? Color(0xFFB34747)
                          : AppColor.green,
                      fontSize: 16,
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
