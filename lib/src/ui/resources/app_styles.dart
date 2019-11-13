import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static ThemeData defaultThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColor.green,
    );
  }

  static TextStyle defaultTitleStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: ScreenUtil.instance.setSp(AppDimen.defaultTitleSize),
        height: ScreenUtil.instance.setHeight(1.4));
  }

  static TextStyle defaultTextStyle() {
    return TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: ScreenUtil.instance.setSp(16),
      height: ScreenUtil.instance.setHeight(1.4),
    );
  }

  static TextStyle balanceTitleStyle() {
    return TextStyle(
      fontSize: ScreenUtil.instance.setSp(15),
      color: Colors.white,
    );
  }

  static TextStyle balanceAmountStyle(amount) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: ScreenUtil.instance.setSp(20),
      color: amount <= 0 ? Colors.red : AppColor.green,
    );
  }

  static TextStyle titleDetailStyle() {
    return TextStyle(
      fontSize: ScreenUtil.instance.setSp(AppDimen.defaultLabelFormSize),
      fontWeight: FontWeight.bold,
      color: AppColor.green,
    );
  }

  static TextStyle valueDetailStyle(Color color) {
    return TextStyle(
      fontSize: ScreenUtil.instance.setSp(AppDimen.valueLabelSize),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle formTextStyle(Color color, double fontSize) => TextStyle(
        fontFamily: 'Roboto',
        fontSize: ScreenUtil.instance.setSp(fontSize),
        color: color,
      );

  static TextStyle buttonTextStyle(Color color, double fontSize) => TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: ScreenUtil.instance.setSp(fontSize),
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.15000000596046448,
      );
}
