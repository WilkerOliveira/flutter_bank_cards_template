import 'package:flutter/material.dart';
import 'package:bank_cards/src/resources/custom_colors.dart' as customColors;

ThemeData defaultThemeData() {
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: customColors.darkBlue,
    accentColor: customColors.darkBlue,
    primaryTextTheme: TextTheme(
      title: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      subtitle: TextStyle(
        fontSize: 12,
        color: customColors.green,
      ),
    ),
    hintColor: customColors.green,
    // Define the default font family.
    fontFamily: 'Roboto',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      title: TextStyle(fontSize: 28.0, fontStyle: FontStyle.normal),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
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
    color: customColors.green,
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
