import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bank_cards/src/resources/dimens.dart';
import 'package:bank_cards/src/resources/styles.dart';
import 'package:bank_cards/src/utils/converter.dart';
import 'package:bank_cards/src/viewmodel/base/BaseViewModel.dart';

class CommonWidgets {
  static BoxDecoration loginBackground() {
    return BoxDecoration(
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.0, 0.5, 1.0],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Converter.hexToColor('#004a91'),
          Converter.hexToColor('#187adf'),
          Converter.hexToColor('#00b9f8'),
        ],
      ),
    );
  }

  static Widget logoImage() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SvgPicture.asset("assets/images/TribancoDigital.svg"),
    );
  }

  static Widget curveImage() {
    return Container(
      child: Image.asset("assets/images/linha_curva.png"),
    );
  }

  static Widget defaultButton(
      mainContext, BaseViewModel model, textButton, onPress) {
    return ButtonTheme(
      minWidth: Dimens.DEFAULT_BOTTOM_WIDTH,
      height: Dimens.DEFAULT_BOTTOM_HEIGHT,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: Text(
          textButton,
          style: defaultTextStyle(),
        ),
        color: Colors.green,
        elevation: 4.0,
        splashColor: Colors.blue,
        onPressed: () {
          onPress(mainContext, model);
        },
      ),
    );
  }

  static Widget customButton(mainContext, BaseViewModel model, textButton,
      onPress, width, height, color) {
    return ButtonTheme(
      minWidth: width,
      height: height,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: Text(
          textButton,
          style: customTextStyle(),
        ),
        color: color,
        elevation: 4.0,
        splashColor: Color(0xFF202858),
        onPressed: () {
          onPress(mainContext, model);
        },
      ),
    );
  }

  static Widget outlineButton(
      mainContext, BaseViewModel model, textButton, onPress) {
    return ButtonTheme(
      minWidth: Dimens.MIN_BOTTOM_WIDTH,
      height: Dimens.MIN_BOTTOM_HEIGHT,
      child: OutlineButton(
        borderSide: BorderSide(
          color: Colors.pinkAccent, //Color of the border
          style: BorderStyle.solid, //Style of the border
          width: 0.5, //width of the border
        ),
        child: Text(
          textButton,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        highlightColor: Colors.pinkAccent,
        splashColor: Colors.blue,
        onPressed: () {
          onPress(mainContext, model);
        },
      ),
    );
  }
}
