import 'package:StatusVaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:StatusVaccini/Screens/components/body_components.dart';

class RecapScreen extends StatefulWidget {
  @override
  _RecapScreenState createState() => _RecapScreenState();
}

class _RecapScreenState extends State<RecapScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar(size, title: SVConst.titleAppBar),
      body: Center(
        child: Text("Hello, in Recap Screen!"),
      ),
    );
  }
}
