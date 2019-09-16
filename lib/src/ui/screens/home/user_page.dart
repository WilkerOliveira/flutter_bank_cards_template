import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
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
