import 'package:bank_cards/src/ui/resources/app_images.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCardFront extends StatefulWidget {
  @override
  _CreditCardFrontState createState() => _CreditCardFrontState();
}

class _CreditCardFrontState extends State<CreditCardFront> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 126,
      width: 390,
      decoration: BoxDecoration(
        color: CustomColors.DARK_BLUE,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFbdc3c7), Color(0xFF2c3e50)],
        ),
        borderRadius: new BorderRadius.all(
            const Radius.circular(Dimens.border_container)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SvgPicture.asset(
              AppImages.VISA,
              width: 64,
              height: 64,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(AppImages.CHIP),
                  Text(
                    "1234  5678  9012  3456",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 15, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("VALID THRU  "),
                      Text(
                        "10/26",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Text(
                    "CARDHOLDER NAME",
                    style: TextStyle(fontSize: 18),
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
