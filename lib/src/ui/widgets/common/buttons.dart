import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:flutter/material.dart';

class Buttons {
  static Widget defaultButton(
      mainContext, BaseViewModel model, textButton, onPress) {
    return ButtonTheme(
      minWidth: AppDimen.defaultBottomWidth,
      height: AppDimen.defaultBottomHeight,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: Text(
          textButton,
          style: AppStyles.defaultTextStyle(),
        ),
        color: AppColor.loginButtonBackground,
        elevation: 4.0,
        splashColor: Colors.blue,
        onPressed: () {
          onPress(mainContext, model);
        },
      ),
    );
  }
}
