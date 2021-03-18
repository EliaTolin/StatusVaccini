import 'package:flutter/material.dart';

//USE THIS CLASS FOR ONLY CONSTANT.

abstract class SVConst {
  //TITLE APPBAR
  static const String titleAppBar = "Status Vaccini";

  //VIEW ROUTE
  static const String MainRoute = '/';
  static const String InfoViewRoute = '/info';
  static const String HomeViewRoute = '/home';
  static const String RecapViewRoute = '/recap';
  //COLOR CONSTANT
  static const barColor = Colors.cyan;
  static const textColor = Colors.white;
  static const backColor = Colors.white;

  //RADIUS ELEMENT
  static const double radiusComponent = 40;

  //SIZE ELEMENT
  static const double kHeighBarRatio = 0.15;
}

abstract class URLConst {
  //URL
  static const String latestSummaryUrl =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/vaccini-summary-latest.json';
}
