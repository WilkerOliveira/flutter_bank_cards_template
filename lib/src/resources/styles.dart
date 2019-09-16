import 'package:bank_cards/src/resources/custom_colors.dart';
import 'package:flutter/material.dart';

ThemeData defaultThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.GREEN,
  );
}

TextStyle defaultTitleStyle() {
  return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 16,
      height: 1.4);
}

TextStyle defaultTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
    height: 1.4,
  );
}

TextStyle customTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 14,
    height: 1.0,
  );
}

TextStyle balanceTitleStyle() {
  return TextStyle(
    fontSize: 18,
    color: CustomColors.GREEN,
    fontWeight: FontWeight.bold,
  );
}

TextStyle balanceAmountStyle() {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 26,
    color: Colors.white,
  );
}
