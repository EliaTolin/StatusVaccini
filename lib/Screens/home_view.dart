import 'package:StatusVaccini/constant.dart';
import 'package:flutter/material.dart';
import 'package:StatusVaccini/Screens/components/body_components.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar(size, title: SVConst.titleAppBar),
      body: Center(
        child: Text("Hello, Home page!"),
      ),
    );
  }
}
