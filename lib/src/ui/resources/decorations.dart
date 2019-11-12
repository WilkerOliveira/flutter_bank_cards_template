import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      contentPadding: EdgeInsets.fromLTRB(
        ScreenUtil.instance.setWidth(20.0),
        ScreenUtil.instance.setWidth(15.0),
        ScreenUtil.instance.setWidth(20.0),
        ScreenUtil.instance.setWidth(15.0),
      ),
      hintText: hint,
      counterStyle: TextStyle(
        color: Colors.white,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ScreenUtil.instance.setWidth(10.0)),
      ),
      errorStyle: TextStyle(color: errorColor),
    );
  }

  static BoxDecoration headerDecoration() {
    return new BoxDecoration(
      color: AppColor.darkBlue,
      gradient: Decorations.gradientDecoration(),
      borderRadius: new BorderRadius.only(
        bottomRight: const Radius.circular(AppDimen.borderContainer),
        bottomLeft: const Radius.circular(AppDimen.borderContainer),
      ),
    );
  }

  static LinearGradient gradientDecoration() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColor.darkBlue, AppColor.topHead],
    );
  }

  static BoxDecoration balanceDecoration() {
    return new BoxDecoration(
      color: AppColor.darkBlue,
      gradient: Decorations.gradientDecoration(),
      borderRadius: new BorderRadius.all(
        const Radius.circular(AppDimen.borderContainer),
      ),
    );
  }

  static BoxDecoration listItemDecoration() {
    return new BoxDecoration(
      color: AppColor.darkBlue,
      gradient: Decorations.gradientDecoration(),
    );
  }
}
