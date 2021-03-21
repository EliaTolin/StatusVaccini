import 'package:StatusVaccini/Screens/components/tabs_navigation.dart';
import 'package:StatusVaccini/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  final String title;
  TabsPage({this.title, Key key}) : super(key: key);
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (int index) => setState(() => _currentIndex = index),
        index: _currentIndex,
        buttonBackgroundColor: SVConst.mainColor,
        backgroundColor: SVConst.backColor,
        color: SVConst.mainColor,
        items: <Widget>[
          for (final tabItem in TabNavigationItem.items) tabItem.icon
        ],
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) => setState(() => _currentIndex = index),
      items: <BottomNavigationBarItem>[
        for (final tabItem in TabNavigationItem.items)
          BottomNavigationBarItem(
            icon: tabItem.icon,
            label: tabItem.title,
          ),
      ],
    );
  }
}
