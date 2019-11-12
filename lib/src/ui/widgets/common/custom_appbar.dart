import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppBarType { simple, silverAppBar }

class CustomAppBar {
  final AppBarType appBarType;
  final String title;
  final bool showBackArrow;

  CustomAppBar({Key key, @required this.appBarType, @required this.title, this.showBackArrow = true});

  Widget build(BuildContext context) {

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
      automaticallyImplyLeading: this.showBackArrow,
      iconTheme: new IconThemeData(color: AppColor.green),
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
      backgroundColor: AppColor.topHead,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      expandedHeight:
          ScreenUtil.instance.setHeight(AppDimen.loginHeaderHeight),
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
            fontSize: ScreenUtil.instance.setSp(26),
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
