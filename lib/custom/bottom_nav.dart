import 'package:flutter/material.dart';
import '../main.dart';
import '../product_watchlist.dart';
import '../budget.dart';
import '../home_page.dart';

Widget customBottomNav(BuildContext context) {
  _onTap(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: "PriceWatch",
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductWatchListPage(
            title: "Watch List",
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BudgetPage(
            title: "Budget",
          ),
        ),
      );
    } else {}
  }

  return BottomNavigationBar(
    backgroundColor: Colors.white,
    unselectedFontSize: 12,
    selectedFontSize:14,
    currentIndex: 0,
    onTap: _onTap,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(
          Icons.fastfood,
          color: Colors.black,
        ),
        title: Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.remove_red_eye, color: Colors.black),
        title: Text(
          'Watch List',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_basket, color: Colors.black),
        title: Text(
          'Budgets',
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
    ],
  );
}
