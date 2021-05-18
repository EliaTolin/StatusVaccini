import 'package:fl_chart/fl_chart.dart';
import 'package:statusvaccini/Models/opendata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:statusvaccini/Screens/components/graphs/graph_linear_ultime_somministrazioni_regioni.dart';

class SomministrazioniRegioneCard extends StatelessWidget {
  @override
  SomministrazioniRegioneCard(
      {@required this.datiRegione, @required this.datiGiornate});

  final List<DatiRegioneGiornata> datiGiornate;
  final Regione datiRegione;
  final numberFormat = NumberFormat.decimalPattern('it');

  // datiGiornate supposto ordinato per data in modo crescente
  DatiRegioneGiornata get latestGiornata => datiGiornate.last;

  List<FlSpot> get graphDosiTotali => datiGiornate
      .map((e) => FlSpot(e.data.millisecondsSinceEpoch.toDouble(),
          e.dosiSomministrate.toDouble()))
      .toList();

  String stringFromDate(DateTime date) =>
      "${date.day}/${date.month}/${date.year}";

  @override
  Widget build(BuildContext context) =>
      GraphLinearUltimeSomministrazioniRegioni(
        dataUltimeSomministrazioni:
            datiGiornate.last.data.difference(DateTime.now()).inMinutes <
                    24 * 60
                ? "oggi"
                : "il giorno ${stringFromDate(datiGiornate.last.data)}",
        typeinfo: "Somministrazioni",
        labelText: "Dosi somministrate in ${datiRegione.nome}",
        iconpath: "assets/icons/syringe.svg",
        funTextInformation: () =>
            Future.value(latestGiornata.dosiSomministrate.toString()),
        funGetData: () => Future.value(graphDosiTotali),
      );
}
