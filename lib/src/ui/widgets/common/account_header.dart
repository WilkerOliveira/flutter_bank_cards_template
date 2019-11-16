import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil.instance.setWidth(AppDimen.marginAccountHeader),
        top: ScreenUtil.instance.setWidth(AppDimen.marginAccountHeader),
        bottom: ScreenUtil.instance.setWidth(AppDimen.marginAccountHeader),
      ),
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil.instance.setHeight(AppDimen.bankAccountHeaderHeight),
      decoration: BoxDecoration(
          color: AppColor.topHead,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )),
      child: Center(
        child: Container(
          decoration: new BoxDecoration(
            //color: CustomColors.GREEN,
            borderRadius: new BorderRadius.only(
              bottomLeft: Radius.circular(
                ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
              ),
              bottomRight: Radius.circular(
                ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
              ),
              topLeft: Radius.circular(
                ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
              ),
              topRight: Radius.circular(
                ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
              ),
            ),
          ),
          width: ScreenUtil.instance.setWidth(AppDimen.bankAccountHeaderWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                S.of(context).bank.toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:
                      ScreenUtil.instance.setSp(AppDimen.bankAccountLabelSize),
                ),
              ),
              Text(
                "999",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      ScreenUtil.instance.setSp(AppDimen.bankAccountValueSize),
                ),
              ),
              Text(
                S.of(context).agency.toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:
                      ScreenUtil.instance.setSp(AppDimen.bankAccountLabelSize),
                ),
              ),
              Text(
                '3892',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      ScreenUtil.instance.setSp(AppDimen.bankAccountValueSize),
                ),
              ),
              Text(
                S.of(context).account.toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:
                      ScreenUtil.instance.setSp(AppDimen.bankAccountLabelSize),
                ),
              ),
              Text(
                '9837-0',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      ScreenUtil.instance.setSp(AppDimen.bankAccountValueSize),
                ),
              ),
              Icon(
                Icons.content_copy,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
