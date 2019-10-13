import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/dimens.dart';
import 'package:flutter/material.dart';

class Decorations {
  static BoxDecoration defaultBorderBoxDecoration() {
    return new BoxDecoration(
      color: Color(0xff587cdb),
      borderRadius: new BorderRadius.only(
        topLeft: const Radius.circular(20.0),
        topRight: const Radius.circular(20.0),
      ),
    );
  }

  static BoxDecoration buttonBoxDecoration(Color color) {
    return new BoxDecoration(
      color: color,
      border: Border.all(color: color, width: 1),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static BoxDecoration transparentButtonBoxDecoration() {
    return new BoxDecoration(
      border: Border.all(color: Color(0xff45619d), width: 1),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static InputDecoration formInputDecoration(String hint, Color errorColor) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorStyle: TextStyle(color: errorColor),
    );
  }

  static BoxDecoration headerDecoration() {
    return new BoxDecoration(
      color: CustomColors.DARK_BLUE,
      gradient: Decorations.gradientDecoration(),
      borderRadius: new BorderRadius.only(
        bottomRight: const Radius.circular(Dimens.border_container),
        bottomLeft: const Radius.circular(Dimens.border_container),
      ),
    );
  }

  static LinearGradient gradientDecoration() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [CustomColors.DARK_BLUE, CustomColors.TOP_HEAD],
    );
  }

  static BoxDecoration balanceDecoration() {
    return new BoxDecoration(
      color: CustomColors.DARK_BLUE,
      gradient: Decorations.gradientDecoration(),
      borderRadius: new BorderRadius.all(
        const Radius.circular(Dimens.border_container),
      ),
    );
  }

  static BoxDecoration listItemDecoration() {
    return new BoxDecoration(
      color: CustomColors.DARK_BLUE,
      gradient: Decorations.gradientDecoration(),
    );
  }
}
