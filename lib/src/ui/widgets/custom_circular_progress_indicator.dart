import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(CustomColors.green),
      strokeWidth: 6.0,
    );
  }
}
