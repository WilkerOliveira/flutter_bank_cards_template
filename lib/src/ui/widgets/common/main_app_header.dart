import 'package:flutter/material.dart';
import 'package:bank_cards/src/resources/custom_colors.dart';

PreferredSizeWidget mainAppHeader(context) {
  return AppBar(
    backgroundColor: CustomColors.BLACK_BAR,
    title: Text("Bank Cards"),
    iconTheme: new IconThemeData(color: CustomColors.GREEN),
    actions: <Widget>[
      // action button
      IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () {

        },
      ),
      // action button
    ],
  );
}
