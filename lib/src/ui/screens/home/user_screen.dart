import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Decorations.gradientDecoration(),
      ),
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(10.0),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'User Data',
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
