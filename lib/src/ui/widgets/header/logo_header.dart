import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Decorations.headerDecoration(),
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil.instance.setHeight(AppDimen.loginHeaderHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil.instance.setWidth(AppDimen.logoLoginMarginTop),
            ),
            child: SvgPicture.asset(
              AppImages.logo,
              width: ScreenUtil.instance.setWidth(AppDimen.logoLoginWidth),
              height: ScreenUtil.instance.setHeight(AppDimen.logoLoginHeight),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: ScreenUtil.instance
                  .setWidth(AppDimen.labelLogoLoginMarginTop),
              bottom: ScreenUtil.instance
                  .setWidth(AppDimen.labelLogoLoginMarginBottom),
            ),
            child: Text(
              S.of(context).app_name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize:
                    ScreenUtil.instance.setSp(AppDimen.labelSplashScreenSize),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
