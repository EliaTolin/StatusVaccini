import 'package:statusvaccini/constants/constant.dart';
import 'package:statusvaccini/constants/route_constant.dart';
import 'package:statusvaccini/Screens/components/body_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/views/undefined_view.dart';
import 'router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LabelUltimeConsegne>(
          create: (context) => LabelUltimeConsegne(),
        ),
        ChangeNotifierProvider<LabelUltimeSomministrazioni>(
          create: (context) => LabelUltimeSomministrazioni(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
