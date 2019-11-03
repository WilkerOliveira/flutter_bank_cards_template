import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppDimen.marginAccountHeader),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                //color: CustomColors.GREEN,
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                ),
              ),
              width: 330.0,
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                   Text(
                      'BANK: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  Text(
                    "999",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),


                 Text(
                      'AGCY: ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                  Text(
                    '3892',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  Text(
                    'ACCT: ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '9837-0',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                 Icon(Icons.content_copy, size: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
