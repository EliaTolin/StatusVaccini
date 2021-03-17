import 'package:StatusVaccini/Screens/home_view.dart';
import 'package:StatusVaccini/Screens/info_screen.dart';
import 'package:StatusVaccini/Screens/undefined_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/tabs_page.dart';
import 'constant.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SVConst.MainRoute:
      return MaterialPageRoute(
          builder: (context) => TabsPage(title: "Status Vaccini"));
    case SVConst.HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePageView());
    case SVConst.InfoViewRoute:
      return MaterialPageRoute(builder: (context) => InfoView());
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedScreen(name: settings.name));
  }
}
