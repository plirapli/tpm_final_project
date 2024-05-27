import 'package:flutter/material.dart';

class AppMenu {
  String? title;
  IconData? icon;
  Widget? page;

  AppMenu({this.title, this.icon, this.page});
}

List<BottomNavigationBarItem> navItem = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.layers),
    label: 'Category',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
];
