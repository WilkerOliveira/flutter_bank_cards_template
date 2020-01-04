import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemWidget extends StatelessWidget {
  final String image;
  final String text;

  const MenuItemWidget({Key key, @required this.image, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        ScreenUtil.instance.setWidth(AppDimen.menuItemPadding),
      ),
      height: ScreenUtil.instance.setHeight(AppDimen.menuItemHeight),
      width: ScreenUtil.instance.setWidth(AppDimen.menuItemWidth),
      decoration: new BoxDecoration(
        border: new Border.all(color: AppColor.green),
        borderRadius: new BorderRadius.only(
          bottomLeft: Radius.circular(
            ScreenUtil.instance.setWidth(AppDimen.menuItemBorderRadius),
          ),
          bottomRight: Radius.circular(
            ScreenUtil.instance.setWidth(AppDimen.menuItemBorderRadius),
          ),
          topRight: Radius.circular(
            ScreenUtil.instance.setWidth(AppDimen.menuItemBorderRadius),
          ),
          topLeft: Radius.circular(
            ScreenUtil.instance.setWidth(AppDimen.menuItemBorderRadius),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            image,
            width: ScreenUtil.instance.setWidth(AppDimen.menuItemImageWidth),
          ),
          Padding(
            padding: EdgeInsets.all(
              ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: ScreenUtil.instance.setSp(AppDimen.menuItemTextSize),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
