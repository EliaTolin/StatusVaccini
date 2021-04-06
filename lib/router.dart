import 'package:statusvaccini/screens/views/home_view.dart';
import 'package:statusvaccini/screens/views/info_view.dart';
import 'package:statusvaccini/screens/views/undefined_view.dart';
import 'package:statusvaccini/constants/route_constant.dart';
import 'package:statusvaccini/screens/main_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteConstant.MainRoute:
      return MaterialPageRoute(
          builder: (context) => MainPage(title: "Status Vaccini"));
    case RouteConstant.HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePageView());
    case RouteConstant.InfoViewRoute:
      return MaterialPageRoute(builder: (context) => InfoView());
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedScreen(name: settings.name));
  }
}
