import 'package:StatusVaccini/Screens/components/home_items.dart';
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
      extendBody: true,
      appBar: TopBar(size, title: SVConst.titleAppBar),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              for (final homeItem in HomeItems.items) homeItem.card,
              // TO DO
              // FIX HEIGHT BODY.
              // WITHOUT SIZEDBOX THE ELEMENT GOING UNDER BOTTOMBAR AT THE END
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
