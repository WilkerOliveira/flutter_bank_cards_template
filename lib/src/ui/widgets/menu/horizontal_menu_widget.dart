import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalMenuWidget extends StatelessWidget {
  final List<Widget> menuItems;

  const HorizontalMenuWidget(
      {Key key, @required this.menuItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
        right: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
      ),
      height: ScreenUtil.instance.setHeight(AppDimen.menuCardHeight),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: this.menuItems,
      ),
    );
    ;
  }
}
