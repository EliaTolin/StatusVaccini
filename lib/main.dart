import 'package:StatusVaccini/Screens/components/body_components.dart';
import 'package:StatusVaccini/constants/constant.dart';
import 'package:StatusVaccini/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/views/undefined_view.dart';
import 'router.dart' as router;

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LabelUltimeConsegne()),
    ], child: MyApp()));

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
      initialRoute: RouteConstant.MainRoute,
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedScreen(name: settings.name)),
    );
  }
}
