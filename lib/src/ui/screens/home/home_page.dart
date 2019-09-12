import 'package:bank_cards/src/ui/screens/home/bank_page.dart';
import 'package:bank_cards/src/ui/screens/home/user_page.dart';
import 'package:flutter/material.dart';
import 'package:bank_cards/src/ui/screens/card/card_page.dart';
import 'package:bank_cards/src/ui/widgets/common/main_app_header.dart';
import 'package:bank_cards/src/ui/widgets/tab/fancy_tab_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    BankPage(),
    CardPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: mainAppHeader(context),
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: FancyTabBar(onTabSelected: this._onItemTapped),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
