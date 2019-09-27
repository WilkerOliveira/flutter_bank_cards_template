import 'package:bank_cards/src/models/card/card.dart' as customCard;
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final customCard.Card cardDto;
  CardWidget({Key key, this.cardDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 445,
      height: 250,
      decoration: new BoxDecoration(
        color: Color(0xff000000),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Text(""),
          Row(
            children: <Widget>[
              Image.asset(""),
              Text(""),
            ],
          ),
          Text(""),
          Row(
            children: <Widget>[
              Text(""),
              Image.asset(""),
            ],
          ),
        ],
      ),
    );
  }
}
