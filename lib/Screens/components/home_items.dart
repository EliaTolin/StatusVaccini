import 'package:StatusVaccini/Models/opendata.dart';
import 'package:StatusVaccini/Screens/components/graph_linear_card.dart';
import 'package:flutter/material.dart';

import 'graph_pie_card.dart';

class HomeItems {
  Widget card;

  HomeItems({@required this.card});

  static List<HomeItems> get items => [
        HomeItems(
          card: GraphPieCard(
            typeinfo: "Dosi",
            labelText: "Dosi consegnate",
            iconpath: "assets/order.svg",
            funTextInformation: () => OpenData.getDosiTotali(),
            funGetData: () => OpenData.graphDeliveryForDay(),
          ),
        ),
        HomeItems(
          card: GraphLinearCard(
            typeinfo: "sommistrazioni",
            labelText: "Vaccini sommistrati",
            iconpath: "assets/virus.svg",
            funTextInformation: () => OpenData.getSomministrazioniTotali(),
            funGetData: () => OpenData.graphVacciniForDay(),
          ),
        ),
        HomeItems(
          card: GraphLinearCard(
            typeinfo: "Dosi",
            labelText: "Dosi consegnate",
            iconpath: "assets/order.svg",
            funTextInformation: () => OpenData.getDosiTotali(),
            funGetData: () => OpenData.graphDeliveryForDay(),
          ),
        ),
      ];
}
