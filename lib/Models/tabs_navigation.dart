import 'package:StatusVaccini/Screens/home_view.dart';
import 'package:StatusVaccini/Screens/info_screen.dart';
import 'package:StatusVaccini/Screens/recap_view.dart';
import 'package:StatusVaccini/constant.dart';
import 'package:flutter/material.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: RecapScreen(),
          icon: Icon(
            Icons.add_chart,
            color: SVConst.backColor,
            size: 35,
          ),
          title: "Recap",
        ),
        TabNavigationItem(
          page: HomePageView(),
          icon: Icon(
            Icons.coronavirus,
            color: SVConst.backColor,
            size: 35,
          ),
          title: "Home",
        ),
        TabNavigationItem(
          page: InfoView(),
          icon: Icon(
            Icons.help,
            color: SVConst.backColor,
            size: 35,
          ),
          title: "Info",
        ),
      ];
}
