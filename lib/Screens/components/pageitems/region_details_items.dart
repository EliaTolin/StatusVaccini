import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:statusvaccini/Models/opendata.dart';
import 'package:statusvaccini/Screens/components/cards/regioni_somministrazioni_summary.dart';
import 'package:statusvaccini/Screens/components/cards/somministrazioni_regione.dart';
import 'package:statusvaccini/Screens/components/graphs/graph_multiple_linear_card.dart';
import 'package:statusvaccini/Screens/components/graphs/graph_linear_ultime_consegne.dart';

class RegionDetailsItems {
  Widget card;

  RegionDetailsItems({@required this.card});

  static Future<List<FlSpot>> getImmunizzazioni(
          List<DatiRegioneGiornata> datiGiornoPerGiorno) =>
      Future.value(datiGiornoPerGiorno
          .map((e) => FlSpot(
              e.data.millisecondsSinceEpoch.toDouble(), e.vaccinati.toDouble()))
          .toList());

  static Future<List<FlSpot>> getDosiSomministrate(
          List<DatiRegioneGiornata> datiGiornoPerGiorno) =>
      Future.value(datiGiornoPerGiorno
          .map((e) => FlSpot(e.data.millisecondsSinceEpoch.toDouble(),
              e.dosiSomministrate.toDouble()))
          .toList());

  static Future<List<FlSpot>> getDosiConsegnate(
          List<DatiRegioneGiornata> datiGiornoPerGiorno) =>
      Future.value(datiGiornoPerGiorno
          .map((e) => FlSpot(e.data.millisecondsSinceEpoch.toDouble(),
              e.dosiConsegnate.toDouble()))
          .toList());

  static int getTotaleImmunizzati(
      List<DatiRegioneGiornata> datiGiornoPerGiorno) {
    int count = 0;
    for (var element in datiGiornoPerGiorno) {
      count += element.vaccinati;
    }
    return count;
  }

  static int getTotaleConsegne(List<DatiRegioneGiornata> datiGiornoPerGiorno) {
    int count = 0;
    for (var element in datiGiornoPerGiorno) {
      count += element.dosiConsegnate;
    }
    return count;
  }

  static int getTotaleSomministrazioni(
      List<DatiRegioneGiornata> datiGiornoPerGiorno) {
    int count = 0;
    for (var element in datiGiornoPerGiorno) {
      count += element.dosiSomministrate;
    }
    return count;
  }

  static List<RegionDetailsItems> getItems(
          Regione regione, List<DatiRegioneGiornata> datiGiornoPerGiorno) =>
      [
        RegionDetailsItems(
            card: RegioniSomministrazioniSummaryCard(
                regione,
                getTotaleImmunizzati(datiGiornoPerGiorno),
                getTotaleConsegne(datiGiornoPerGiorno),
                getTotaleSomministrazioni(datiGiornoPerGiorno))),
        RegionDetailsItems(
          card: SomministrazioniRegioneCard(
            datiRegione: regione,
            datiGiornate: datiGiornoPerGiorno
              ..sort((a, b) =>
                  a.data.millisecondsSinceEpoch -
                  b.data.millisecondsSinceEpoch),
          ),
        ),
        RegionDetailsItems(
          card: GraphMultipleLinearCard(
            labelText: "Vaccinati e dosi somministrate",
            iconpath: "assets/icons/syringe.svg",
            funGetData: [
              () => getDosiSomministrate(datiGiornoPerGiorno),
              () => getImmunizzazioni(datiGiornoPerGiorno),
            ],
            textLegends: ["Somministrazioni totali", "Seconde dosi e dosi J&J"],
          ),
        ),
        RegionDetailsItems(
            card: GraphLinearUltimeConsegne(
          iconpath: "assets/icons/order.svg",
          labelText: "Dosi consegnate in ${regione.nome}",
          // secondLabelText: "totali",
          typeinfo: "Dosi",
          funTextInformation: () =>
              OpenData.getUltimeDosiConsegnatePerRegione(regione.sigla),
          funGetData: () =>
              OpenData.graphConsegnePerGiornoPerRegione(regione.sigla),
        ))
      ];
}
