import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:statusvaccini/Models/opendata.dart';
import 'package:intl/intl.dart';
import 'package:statusvaccini/Models/repositories/data_information.dart';

class RegioniSomministrazioniSummaryCard extends StatelessWidget {
  RegioniSomministrazioniSummaryCard(this.regione, this.totaleImmunizzati,
      this.totaleConsegne, this.totaleSomministrazioni);

  final Regione regione;
  final int totaleImmunizzati;
  final int totaleConsegne;
  final int totaleSomministrazioni;

  String getPercentuale(int valore) {
    String value = "";
    double percentuale =
        (valore * 100) / DataInformation.abitantiRegioni[regione.sigla];
    percentuale = double.parse((percentuale.toStringAsFixed(2)));
    value = percentuale.toString() + " % ";
    return value;
  }

  String getPercentualeSomministrazioni() {
    String value = "";
    double percentuale = (totaleSomministrazioni * 100) / totaleConsegne;
    percentuale = double.parse((percentuale.toStringAsFixed(2)));
    value = percentuale.toString() + " % ";
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('it');
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SVConst.radiusComponent),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Dosi consegnate",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: const Color(0xff379982),
                      ),
                    ),
                    SizedBox(width: 10),
                    AutoSizeText(
                      numberFormat.format(totaleConsegne),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Dosi somministrate",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: const Color(0xff379982),
                      ),
                    ),
                    SizedBox(width: 10),
                    AutoSizeText(
                      numberFormat.format(totaleSomministrazioni),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        AutoSizeText.rich(
                          TextSpan(
                            text: getPercentualeSomministrazioni(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'delle dosi consegnate',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          maxLines: 3,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AutoSizeText(
              "Prime dosi",
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: const Color(0xff379982),
              ),
            ),
            SizedBox(width: 10),
            AutoSizeText(
              numberFormat.format(regione.primeDosi),
              maxLines: 1,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 10),
            Column(
              children: [
                AutoSizeText.rich(
                  TextSpan(
                    text: getPercentuale(regione.primeDosi),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'della popolazione',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  maxLines: 3,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Immunizzati",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: const Color(0xff379982),
                      ),
                    ),
                    SizedBox(width: 10),
                    AutoSizeText(
                      numberFormat.format(totaleImmunizzati),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        AutoSizeText.rich(
                          TextSpan(
                            text: getPercentuale(totaleImmunizzati),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'della popolazione',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          maxLines: 3,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
