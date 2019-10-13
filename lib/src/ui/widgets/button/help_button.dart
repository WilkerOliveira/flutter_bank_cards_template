import 'package:flutter/material.dart';
import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/styles.dart' as style;

class HelpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
              const IconData(59527,
                  fontFamily: 'MaterialIcons', matchTextDirection: true),
              size: 22.0,
              color: Colors.white),
          Text(
            S.of(context).help,
            style: style.defaultTextStyle(),
          )
        ],
      ),
    );
  }
}
