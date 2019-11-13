import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCardFront extends StatefulWidget {
  @override
  _CreditCardFrontState createState() => _CreditCardFrontState();
}

class _CreditCardFrontState extends State<CreditCardFront> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
      ),
      height: ScreenUtil.instance.setHeight(AppDimen.creditCardHeight),
      width: ScreenUtil.instance.setWidth(AppDimen.creditCardWidth),
      decoration: BoxDecoration(
        color: AppColor.darkBlue,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.creditCardFirstColor,
            AppColor.creditCardSecondColor,
          ],
        ),
        borderRadius: new BorderRadius.all(
            const Radius.circular(AppDimen.borderContainer)),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SvgPicture.asset(
              AppImages.visa,
              width: ScreenUtil.instance.setWidth(AppDimen.creditCardLogoWidth),
              height:
                  ScreenUtil.instance.setHeight(AppDimen.creditCardLogoHeight),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
                right: ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(AppImages.chip),
                  Text(
                    "1234  5678  9012  3456",
                    style: AppStyles.formTextStyle(
                      Colors.white,
                      AppDimen.creditCardNumberSize,
                    ).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
                top: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
                right: ScreenUtil.instance.setWidth(AppDimen.simpleMargin),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        S.of(context).valid_thru,
                        style: AppStyles.formTextStyle(
                          Colors.white,
                          AppDimen.defaultLabelFormSize,
                        ),
                      ),
                      Text(
                        "10/26",
                        style: AppStyles.formTextStyle(
                          Colors.white,
                          AppDimen.defaultLabelFormSize,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "CARDHOLDER NAME",
                    style: AppStyles.formTextStyle(
                      Colors.white,
                      AppDimen.defaultLabelFormSize,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
