import 'package:statusvaccini/Screens/views/home_view.dart';
import 'package:statusvaccini/Screens/views/info_view.dart';
import 'package:statusvaccini/constants/constant.dart';
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
