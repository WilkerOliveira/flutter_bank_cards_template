import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:flutter_svg/svg.dart';

enum AppBarType { simple, silverAppBar }

class CustomAppBar {
  final AppBarType appBarType;
  final String title;

  CustomAppBar({Key key, @required this.appBarType, @required this.title});

  Widget build(BuildContext context) {
    BaseScreen.initScreenUtil(context: context);

    if (this.appBarType == AppBarType.simple)
      return this._mainAppHeader(context, title);

    return this._silverAppbar(context, title);
  }

  PreferredSizeWidget _mainAppHeader(context, title) {
    return AppBar(
      flexibleSpace: Container(
          decoration: BoxDecoration(
        gradient: Decorations.gradientDecoration(),
      )),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: new IconThemeData(color: CustomColors.green),
      actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        ),
        // action button
      ],
    );
  }

  Widget _silverAppbar(context, title) {
    return SliverAppBar(
      backgroundColor: CustomColors.topHead,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      expandedHeight:
          BaseScreen.screenUtil.setHeight(AppDimen.loginHeaderHeight),
      floating: false,
      pinned: true,
      elevation: 2.0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: BaseScreen.screenUtil.setSp(26),
            color: Colors.white,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            DecoratedBox(
              decoration: Decorations.headerDecoration(),
            ),
//            SvgPicture.asset(
//              AppImages.logo,
//              width: 1,
//              height: 1,
//            ),
          ],
        ),
      ),
    );
  }
}
