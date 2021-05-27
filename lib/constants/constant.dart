import 'package:flutter/material.dart';

//USE THIS CLASS FOR ONLY CONSTANT.

class SVConst {
  //TITLE APPBAR
  static const String titleAppBar = "Status Vaccini";

  //COLOR CONSTANT
  static const mainColor = Colors.cyan;
  static const textColor = Colors.white;
  static Color backColor = Colors.grey.shade200;
  static const iconColor = mainColor;
  static const cardColor = Colors.white;

  static const List<Color> listColors = [
    Color.fromARGB(255, 172, 25, 100),
    Color.fromRGBO(255, 172, 25, 100),
    Color.fromRGBO(13, 255, 118, 100),
    Color.fromRGBO(255, 43, 25, 100),
    Color.fromRGBO(13, 128, 255, 100),
    Color.fromARGB(100, 255, 172, 25),
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.grey,
    Colors.cyan,
  ];

  static const List<Color> circularItemsColors = [
    Color(0xFFF3722C),
    Color(0xFFF49CBB),
    Color.fromARGB(255, 172, 25, 100),
    Color(0xFFF9C74F),
    Color(0xFF90BE6D),
    Color(0xFFE9AFA3),
    Colors.cyan,
    Color(0xFFF8961E),
    Color(0xFF577590),
    Color(0xFFBC2C1A),
    Color(0xFF8980F5),
    Colors.amber,
    Color(0xFF417B5A),
    Color(0xFF2EC0F9),
    Color(0xFFDD2D4A),
    Color(0xFFE9D2C0),
    Color(0xFF880D1E),
    Color(0xFFF26A8D),
    Color(0xFF67AAF9),
    Color(0xFFCBEEF3),
    Color(0xFF43AA8B),
    Color(0xFF2AB7CA),
    Color.fromRGBO(255, 172, 25, 100),
  ];

  static const List<Color> circularFixItemsColors = [
    Color(0xFFFF0054),
    Colors.amber,
    Color(0xFFF3722C),
    Color(0xFFE9AFA3),
    Color(0xFFF8961E),
    Color(0xFFF9C74F),
    Color(0xFF90BE6D),
    Color(0xFF43AA8B),
    Color(0xFF577590),
    Color(0xFF67AAF9),
    Color(0xFF2EC0F9),
    Color(0xFFCBEEF3),
    Color(0xFF8980F5),
    Color(0xFFF49CBB),
    Color(0xFFF26A8D),
    Color(0xFFDD2D4A),
    Color(0xFF880D1E),
    Color(0xFFBC2C1A),
    Color(0xFF2AB7CA),
    Color(0xFF417B5A),
  ];

  static const List<Color> linearColors = [
    Colors.cyan,
    Color.fromARGB(255, 172, 25, 100),
    Color.fromRGBO(255, 172, 25, 100),
    Color.fromRGBO(13, 255, 118, 100),
    Color.fromRGBO(255, 43, 25, 100),
    Color.fromRGBO(13, 128, 255, 100),
    Color.fromARGB(100, 255, 172, 25),
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.grey,
  ];

  static const Color itemBarColor = Colors.cyan;
  static const Color itemSelectedBarColor = Color.fromARGB(255, 172, 25, 100);
  static const Color itemBackBarColor = Colors.white;
  static const Color tooltipDataBarColor =
      Color.fromARGB(255, 172, 25, 100); //Color(0xff81e5cd);
  static const Color textBarColor = Colors.black;
  static const Color textItemBarColor = Colors.white;
  static const Color textGreen = const Color(0xff379982);
  //RADIUS ELEMENT
  static const double radiusComponent = 40;

  //SIZE ELEMENT
  static const double kHeighBarRatio = 0.15;
  static const double kSizeIcons = 50;
  static const double kSizeIconsSmall = 30;
}
