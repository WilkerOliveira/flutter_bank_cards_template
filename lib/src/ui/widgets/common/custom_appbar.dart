import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';

enum AppBarType {

  simple,
  silverAppBar

}

class CustomAppBar {

  final AppBarType appBarType;
  final String title;

  CustomAppBar({Key key, @required this.appBarType, @required this.title});

  Widget build(BuildContext context) {

    if(this.appBarType == AppBarType.simple)
      return this._mainAppHeader(context, title);

    return this._silverAppbar(context, title);
  }

  PreferredSizeWidget _mainAppHeader(context, title) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: Decorations.gradientDecoration(),
        )
      ),
      title: Text(title),
      iconTheme: new IconThemeData(color: CustomColors.GREEN),
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
      backgroundColor: CustomColors.TOP_HEAD,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      expandedHeight: Dimens.login_header_height,
      floating: false,
      pinned: true,
      elevation: 2.0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 26),
        ),
        background: Stack(fit: StackFit.expand, children: <Widget>[
          DecoratedBox(decoration: Decorations.headerDecoration()),
          Image.asset(AppImages.LOGO_IMAGE),
        ]),
      ),
    );
  }


}
