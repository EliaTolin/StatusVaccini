import 'package:statusvaccini/screens/components/tabs_navigation.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String title;
  MainPage({this.title, Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        onTap: (int index) => setState(() => _currentIndex = index),
        index: _currentIndex,
        buttonBackgroundColor: SVConst.mainColor,
        backgroundColor: Colors.transparent,
        color: SVConst.mainColor,
        items: <Widget>[
          for (final tabItem in TabNavigationItem.items) tabItem.icon
        ],
      ),
    );
  }
}
