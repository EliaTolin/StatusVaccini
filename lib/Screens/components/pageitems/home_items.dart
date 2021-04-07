import 'package:statusvaccini/models/opendata.dart';
import 'package:statusvaccini/screens/components/graphs/graph_bar_card.dart';
import 'package:statusvaccini/screens/components/graphs/graph_linear_card.dart';
import 'package:statusvaccini/screens/components/graphs/graph_multiple_linear_card.dart';
import 'package:statusvaccini/screens/components/cards/regioni_card_view.dart';
import 'package:statusvaccini/screens/components/graphs/graph_linear_ultime_consegne.dart';
import 'package:statusvaccini/screens/components/graphs/graph_linear_ultime_sommistrazioni.dart';
import 'package:flutter/material.dart';

import '../graphs/graph_pie_card.dart';

class HomeItems {
  Widget card;

  HomeItems({@required this.card});

  static List<HomeItems> get items => [
        HomeItems(
          card: GraphLinearUltimeSommistrazioni(
            typeinfo: "sommistrazioni",
            labelText: "Sommistrazioni",
            iconpath: "assets/icons/date.svg",
            funTextInformation: () => OpenData.getUltimeSommistrazioni(),
            funGetData: () => OpenData.graphVacciniForDay(),
          ),
        ),
        HomeItems(
          card: GraphLinearCard(
            typeinfo: "sommistrazioni",
            labelText: "Vaccini sommistrati",
            secondLabelText: "",
            iconpath: "assets/icons/virus.svg",
            funTextInformation: () => OpenData.getSomministrazioniTotali(),
            funGetData: () => OpenData.graphVacciniTotal(),
          ),
        ),
        HomeItems(
          card: GraphBarCard(
            labelText: "Sommistrazioni",
            secondLabelText: "Per fascia d'età",
            iconpath: "assets/icons/bar-chart.svg",
            funGetData: () => OpenData.getInfoSommistrazioniFasceEta(),
          ),
        ),
        HomeItems(
          card: GraphPieCard(
            typeinfo: "Dosi",
            labelText: "Dosi per fornitore",
            iconpath: "assets/icons/order.svg",
            funTextInformation: () => OpenData.getDosiTotali(),
            funGetData: () => OpenData.graphDeliveryForDay(),
          ),
        ),
        HomeItems(
          card: GraphLinearCard(
            typeinfo: "Dosi",
            labelText: "Dosi consegnate",
            secondLabelText: "in totale",
            iconpath: "assets/icons/order.svg",
            funTextInformation: () => OpenData.getDosiTotali(),
            funGetData: () => OpenData.graphDeliveryTotal(),
          ),
        ),
        HomeItems(
          card: GraphLinearUltimeConsegne(
            typeinfo: "Dosi",
            labelText: "Dosi consegnate",
            iconpath: "assets/icons/date.svg",
            funTextInformation: () => OpenData.getUltimeDosiConsegnate(),
            funGetData: () => OpenData.graphDeliveryForDay(),
          ),
        ),
        HomeItems(
          card: GraphMultipleLinearCard(
            typeinfo: "Dosi",
            labelText: "Prime e seconde dosi",
            iconpath: "assets/icons/medal.svg",
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
            iconpath: "assets/icons/placeholder.svg",
            funGetData: () =>
                OpenData.getInfoSommistrazioniFasceEtaPerRegione(),
            firstLabel: "Sommistrazioni per regione",
            secondLabel: "in rapporto agli abitanti",
          ),
        ),
      ];
}
