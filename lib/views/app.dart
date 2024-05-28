import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tpm_final_project/models/app_menu.dart';
import 'package:tpm_final_project/theme.dart';
import 'package:tpm_final_project/views/menu/category.dart';
import 'package:tpm_final_project/views/menu/home.dart';
import 'package:tpm_final_project/views/menu/profile.dart';

class AppPage extends StatefulWidget {
  final String token;
  const AppPage({super.key, required this.token});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions(String token) {
    return [
      HomePage(data: JwtDecoder.decode(token)),
      const CategoryPage(),
      ProfilePage(data: JwtDecoder.decode(token)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(navItem[_selectedIndex].label!)),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: MyTheme.bg,
          child: _widgetOptions(widget.token).elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: navItem,
          currentIndex: _selectedIndex,
          unselectedItemColor: const Color.fromARGB(255, 169, 169, 169),
          selectedFontSize: 12.0,
          selectedItemColor: Colors.black,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
