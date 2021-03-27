import 'package:StatusVaccini/Models/opendata.dart';
import 'package:StatusVaccini/Screens/components/graph_bar_card.dart';
import 'package:StatusVaccini/Screens/components/graph_linear_card.dart';
import 'package:StatusVaccini/Screens/components/graph_multiple_linear_card.dart';
import 'package:StatusVaccini/Screens/components/regioni_card_view.dart';
import 'package:flutter/material.dart';

import 'graph_pie_card.dart';

class HomeItems {
  Widget card;

  HomeItems({@required this.card});

  static List<HomeItems> get items => [
        HomeItems(
          card: GraphLinearCard(
            typeinfo: "sommistrazioni",
            labelText: "Sommistrazioni",
            secondLabelText: "Oggi",
            iconpath: "assets/date.svg",
            funTextInformation: () => OpenData.getUltimeSommistrazioni(),
            funGetData: () => OpenData.graphVacciniForDay(),
          ),
        ),
        HomeItems(
          card: GraphLinearCard(
            typeinfo: "sommistrazioni",
            labelText: "Vaccini sommistrati",
            secondLabelText: "",
            iconpath: "assets/virus.svg",
            funTextInformation: () => OpenData.getSomministrazioniTotali(),
            funGetData: () => OpenData.graphVacciniTotal(),
          ),
        ),
        HomeItems(
          card: GraphBarCard(
            labelText: "Sommistrazioni",
            secondLabelText: "Per fascia d'età",
            iconpath: "assets/bar-chart.svg",
            funGetData: () => OpenData.getInfoSommistrazioni(),
          ),
        ),
        HomeItems(
          card: GraphPieCard(
            typeinfo: "Dosi",
            labelText: "Dosi per fornitore",
            iconpath: "assets/order.svg",
            funTextInformation: () => OpenData.getDosiTotali(),
            funGetData: () => OpenData.graphDeliveryForDay(),
          ),
        ),
        HomeItems(
          card: GraphLinearCard(
            typeinfo: "Dosi",
            labelText: "Dosi consegnate",
            secondLabelText: "in totale",
            iconpath: "assets/order.svg",
            funTextInformation: () => OpenData.getDosiTotali(),
            funGetData: () => OpenData.graphDeliveryForDay(),
          ),
        ),
        HomeItems(
          card: GraphLinearCard(
            typeinfo: "Dosi",
            labelText: "Dosi consegnate",
            secondLabelText: "oggi",
            iconpath: "assets/date.svg",
            funTextInformation: () => OpenData.getUltimeDosiConsegnate(),
            funGetData: () => OpenData.graphDeliveryTotal(),
          ),
        ),
        HomeItems(
          card: GraphMultipleLinearCard(
            typeinfo: "Dosi",
            labelText: "Prime e seconde dosi",
            iconpath: "assets/date.svg",
            funGetData: [
              () => OpenData.graphPrimeDosi(),
              () => OpenData.graphSecondeDosi(),
            ],
            textLegends: ["Prime dosi", "Seconde dosi"],
          ),
        ),
        HomeItems(
          card: CardViewRegioni(
            labelText: "Sommistrazioni",
            iconpath: "assets/virus.svg",
            funGetData: () => OpenData.getInfoPerRegione(),
            firstLabel: "Sommistrazioni per regione",
            secondLabel: "in rapporto agli abitanti",
          ),
        ),
      ];
}
