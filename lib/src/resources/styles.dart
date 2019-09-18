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

BoxDecoration balanceDecoration() {
  return new BoxDecoration(
    borderRadius: new BorderRadius.only(
      bottomLeft: const Radius.circular(15.0),
      bottomRight: const Radius.circular(15.0),
      topLeft: const Radius.circular(15.0),
      topRight: const Radius.circular(15.0),
    ),
    gradient: LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [0.3, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        //Colors.indigo[800],
        Colors.indigo[700],
        Colors.indigo[500],
        //Colors.indigo[400],
      ],
    ),
  );
}

