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
    fontSize: 15,
    color: Colors.white,
  );
}

TextStyle balanceAmountStyle(amount) {
  return TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: amount <= 0 ? Colors.red : CustomColors.GREEN,
  );
}

TextStyle titleDetailStyle() {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: CustomColors.GREEN,
  );
}

BoxDecoration balanceDecoration() {
  return new BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end:
      Alignment(1.0, 0.0),
      colors: [
        const Color(0xFF707070),
        const Color(0xFFbdbdbd)
      ], // whitish to gray
      tileMode: TileMode.repeated,
    ),
  );
}
