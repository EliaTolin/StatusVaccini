import 'package:flutter/material.dart';
import 'package:StatusVaccini/Screens/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Status Vaccini",
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          HomePage.routeName: (BuildContext context) =>
              HomePage(title: "Status Vaccini"),
        });
  }
}
