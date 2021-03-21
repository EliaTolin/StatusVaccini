import 'package:StatusVaccini/Models/opendata.dart';
import 'package:StatusVaccini/constant.dart';
import 'package:flutter/material.dart';
import 'package:StatusVaccini/Screens/components/body_components.dart';

import 'components/graph_card.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GraphCard(
          typeinfo: "Dosi",
          labelText: "Vaccini sommistrati",
          iconpath: "assets/virus.svg",
          funTextInformation: () => OpenData.getVaccinatiTotale(),
          funGetData: () => OpenData.graphVacciniForDay(),
        ),
      ),
    );
  }
}
