import 'package:bank_cards/src/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/screens/home/bank_page.dart';
import 'package:bank_cards/src/ui/screens/home/user_page.dart';
import 'package:bank_cards/src/ui/widgets/custom_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bank_cards/src/ui/screens/card/card_page.dart';
import 'package:bank_cards/src/ui/widgets/common/main_app_header.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    CardPage(),
    BankPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppHeader(context),
      drawer: CustomDrawer(),
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: CurvedNavigationBar(
        color: CustomColors.BLACK_BAR,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.credit_card, size: 30, color: CustomColors.GREEN,),
          Icon(Icons.attach_money, size: 30, color: CustomColors.GREEN,),
          Icon(Icons.person, size: 30, color: CustomColors.GREEN,),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
