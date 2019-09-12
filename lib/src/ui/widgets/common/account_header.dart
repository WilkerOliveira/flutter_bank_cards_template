import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/normal_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Color(0xFFDC0F7D),
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(15.0),
                  bottomRight: const Radius.circular(15.0),
                  topLeft: const Radius.circular(15.0),
                  topRight: const Radius.circular(15.0),
                ),
              ),
              width: 330.0,
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      'Banco: ' + "634",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      'Agency: 001',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    'Account: 9837-0',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
