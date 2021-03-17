import 'package:StatusVaccini/constant.dart';
import 'package:flutter/material.dart';
import 'package:StatusVaccini/Screens/components/body_components.dart';

class InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar(size, title: SVConst.titleAppBar),
      body: Center(
        child: Text("Hello, Info Screen!"),
      ),
    );
  }
}
