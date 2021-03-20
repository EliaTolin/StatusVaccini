import 'package:StatusVaccini/constant.dart';
import 'package:flutter/material.dart';
import 'Screens/undefined_screen.dart';
import 'router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Status Vaccini",
      theme: ThemeData(
        primaryColor: SVConst.mainColor,
        scaffoldBackgroundColor: SVConst.backColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SVConst.MainRoute,
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedScreen(name: settings.name)),
    );
  }
}
