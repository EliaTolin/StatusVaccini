import 'package:StatusVaccini/Models/opendata.dart';
import 'package:StatusVaccini/Screens/components/graph_card.dart';
import 'package:flutter/material.dart';

class HomeItems {
  Widget card;

  HomeItems({@required this.card});

  static List<HomeItems> get items => [
        HomeItems(
          card: GraphCard(
            typeinfo: "Dosi",
            labelText: "Vaccini sommistrati",
            iconpath: "assets/virus.svg",
            funTextInformation: () => OpenData.getSomministrazioniTotali(),
            funGetData: () => OpenData.graphVacciniForDay(),
          ),
        ),
      ];
}
