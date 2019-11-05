import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/styles.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Buttons {
  static Widget defaultButton(
      mainContext, BaseViewModel model, textButton, onPress, ScreenUtil screenUtil) {
    return ButtonTheme(
      minWidth: AppDimen.defaultBottomWidth,
      height: AppDimen.defaultBottomHeight,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: Text(
          textButton,
          style: defaultTextStyle(screenUtil),
        ),
        color: CustomColors.loginButtonBackground,
        elevation: 4.0,
        splashColor: Colors.blue,
        onPressed: () {
          onPress(mainContext, model);
        },
      ),
    );
  }

  static Widget customButton(mainContext, BaseViewModel model, textButton,
      onPress, width, height, color) {
    return ButtonTheme(
      minWidth: width,
      height: height,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: Text(
          textButton,
          style: customTextStyle(),
        ),
        color: color,
        elevation: 4.0,
        splashColor: Color(0xFF202858),
        onPressed: () {
          onPress(mainContext, model);
        },
      ),
    );
  }

  static Widget outlineButton(
      mainContext, BaseViewModel model, textButton, onPress) {
    return ButtonTheme(
      minWidth: AppDimen.minBottomWidth,
      height: AppDimen.minBottomHeight,
      child: OutlineButton(
        borderSide: BorderSide(
          color: Colors.pinkAccent, //Color of the border
          style: BorderStyle.solid, //Style of the border
          width: 0.5, //width of the border
        ),
        child: Text(
          textButton,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        highlightColor: Colors.pinkAccent,
        splashColor: Colors.blue,
        onPressed: () {
          onPress(mainContext, model);
        },
      ),
    );
  }
}