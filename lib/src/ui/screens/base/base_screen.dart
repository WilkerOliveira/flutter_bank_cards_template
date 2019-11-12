import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseScreen {

  static void initScreenUtil({@required BuildContext context}) {
    ScreenUtil.instance = ScreenUtil(
      width: AppDimen.baseScreenWidth,
      height: AppDimen.baseScreenHeight,
    )..init(context);
  }
}
