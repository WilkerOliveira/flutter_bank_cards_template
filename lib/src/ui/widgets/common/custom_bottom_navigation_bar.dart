import 'package:bank_cards/src/ui/resources/app_color.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function onItemTapped;

  CustomBottomNavigationBar({@required this.items, @required this.currentIndex, @required this.onItemTapped});

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColor.topHead,
        items: this.items,
        currentIndex: this.currentIndex,
        selectedItemColor: AppColor.green,
        onTap: this.onItemTapped,
      ),
    );
  }

}