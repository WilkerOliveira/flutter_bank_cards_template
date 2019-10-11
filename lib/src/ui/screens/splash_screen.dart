import 'dart:async';

import 'package:bank_cards/src/resources/app_images.dart';
import 'package:bank_cards/src/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.GRAY_BAR,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: SvgPicture.asset(
              AppImages.LOGO,
              width: 150,
              height: 150,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: Text(
              "Mobile Bank Template",
              style: TextStyle(
                fontSize: 22,
                color: CustomColors.GREEN,
              ),
            ),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.GREEN),
          ),
        ],
      ),
    );
  }
}
