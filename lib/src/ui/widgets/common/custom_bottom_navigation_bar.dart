import 'package:bank_cards/src/ui/resources/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function onItemTapped;

  CustomBottomNavigationBar({@required this.items, @required this.currentIndex, @required this.onItemTapped});

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      backgroundColor: CustomColors.TOP_HEAD,
      items: this.items,
      currentIndex: this.currentIndex,
      selectedItemColor: CustomColors.GREEN,
      onTap: this.onItemTapped,
    );
  }

}