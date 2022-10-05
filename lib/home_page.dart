import 'package:flutter/material.dart';

import 'assets/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle _optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      "1",
      style: _optionStyle,
    ),
    Text(
      "2",
      style: _optionStyle,
    ),
    Text(
      "3",
      style: _optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.whiteBackgroundColor,
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: AppTheme.blackAppTextColor),
          title: const Text("App"),
          elevation: 0,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.accessibility), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "")
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppTheme.blackAppTextColor,
          onTap: _onItemTapped,
          backgroundColor: AppTheme.whiteBackgroundColor,
        ));
  }
}
