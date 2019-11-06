import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static ThemeData defaultThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: CustomColors.green,
    );
  }

  static TextStyle defaultTitleStyle(ScreenUtil screenUtil) {
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: screenUtil.setSp(AppDimen.defaultTitleSize),
        height: 1.4);
  }

  static TextStyle defaultTextStyle(ScreenUtil screenUtil) {
    return TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: screenUtil.setSp(16),
      height: 1.4,
    );
  }

  static TextStyle customTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 14,
      height: 1.0,
    );
  }

  static TextStyle balanceTitleStyle() {
    return TextStyle(
      fontSize: 15,
      color: Colors.white,
    );
  }

  static TextStyle balanceAmountStyle(amount) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: amount <= 0 ? Colors.red : CustomColors.green,
    );
  }

  static TextStyle titleDetailStyle(ScreenUtil instance) {
    return TextStyle(
      fontSize: instance.setSp(AppDimen.labelFormDefaultSize),
      fontWeight: FontWeight.bold,
      color: CustomColors.green,
    );
  }

  static TextStyle valueDetailStyle(ScreenUtil instance, Color color) {
    return TextStyle(
      fontSize: instance.setSp(AppDimen.valueLabelSize),
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle formTextStyle(Color color, double fontSize) => TextStyle(
        fontFamily: 'Roboto',
        fontSize: fontSize,
        color: color,
      );

  static TextStyle buttonTextStyle(Color color, double fontSize) => TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.15000000596046448,
      );
}
