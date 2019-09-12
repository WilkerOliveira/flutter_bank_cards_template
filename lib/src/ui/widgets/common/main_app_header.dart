import 'package:flutter/material.dart';
import 'package:bank_cards/src/resources/dimens.dart';
import 'package:bank_cards/src/resources/images.dart';

PreferredSizeWidget mainAppHeader(context) {
  return PreferredSize(
    preferredSize: Size(null, Dimens.HEADER_PREFERRED_SIZE),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: Dimens.HEADER_SIZE,
      //color: Colors.blueAccent,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(Images.BLUE_BACKGROUND),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/avatar.png",
                width: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Hello, User Name",
                    style: Theme.of(context).primaryTextTheme.title,
                  ),
                  Text(
                    "Your last accesss was 2019-01-01 at 18:20",
                    style: Theme.of(context).primaryTextTheme.subtitle,
                  ),
                ],
              ),
              Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
