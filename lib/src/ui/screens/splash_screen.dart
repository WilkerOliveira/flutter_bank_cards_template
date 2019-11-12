import 'dart:async';

import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/screens/base/base_screen.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/screens/home/home_screen.dart';
import 'package:bank_cards/src/ui/screens/login/login_screen.dart';
import 'package:bank_cards/src/viewmodel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer> loadData(SplashViewModel model) async {
    return new Timer(Duration(seconds: 3), () async {
      User currentUser = await model.getCurrentUser();

      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BaseScreen.initScreenUtil(context: context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BaseWidget<SplashViewModel>(
        model: SplashViewModel(Provider.of(context)),
        onModelReady: (model) async {
          loadData(model);
        },
        builder: (mainContext, model, child) => Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: Decorations.gradientDecoration(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(
                  ScreenUtil.instance
                      .setWidth(AppDimen.imageSplashScreenPadding),
                ),
                child: SvgPicture.asset(
                  AppImages.logo,
                  width: ScreenUtil.instance
                      .setWidth(AppDimen.imageSplashScreenWidth),
                  height: ScreenUtil.instance
                      .setHeight(AppDimen.imageSplashScreenHeight),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  ScreenUtil.instance
                      .setWidth(AppDimen.labelSplashScreenPadding),
                ),
                child: Text(
                  S.of(context).app_name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil.instance
                        .setSp(AppDimen.labelSplashScreenSize),
                  ),
                ),
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
