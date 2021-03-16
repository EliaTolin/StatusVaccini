import 'package:StatusVaccini/Screens/components/BodyComponents.dart';
import 'package:flutter/material.dart';
import 'package:StatusVaccini/constant.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  final String title;
  HomePage({this.title, Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: TopBar(size, title: "Status Vaccini"),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Hello World!"),
                    ])
              ])),
    );
  }
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Size size;
  final Function onPressed;
  final Function onTitleTapped;
  final Widget child;
  
  @override
  final Size preferredSize;

  TopBar(this.size,
      {@required this.title, this.child, this.onPressed, this.onTitleTapped})
      : preferredSize = Size.fromHeight(size.height * SVConst.kHeighBarRatio);
  @override
  Widget build(BuildContext context) {
    return buildTopBar(size, title);
  }
}
