import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:bank_cards/src/ui/screens/home/bank_screen.dart';
import 'package:bank_cards/src/ui/screens/home/user_screen.dart';
import 'package:bank_cards/src/ui/widgets/common/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bank_cards/src/ui/screens/card/card_screen.dart';
import 'package:bank_cards/src/ui/widgets/common/custom_appbar.dart';

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

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              appBarType: AppBarType.simple, title: S.of(context).app_name)
          .build(context),
      //drawer: CustomDrawer(),
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            title: Text(S.of(context).cards),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text(S.of(context).account),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(S.of(context).user),
          ),
        ],
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}