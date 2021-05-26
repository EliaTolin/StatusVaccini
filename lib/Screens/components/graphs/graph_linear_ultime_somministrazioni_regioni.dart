import 'package:statusvaccini/constants/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

/// basata sul GraphLinearUltimeSomministrazioni ma cambiato
/// per poterlo usare con i dati delle regioni
class GraphLinearUltimeSomministrazioniRegioni extends StatelessWidget {
  final String typeinfo;
  final String labelText;
  final String iconpath;
  final Function funTextInformation;
  final Function funGetData;
  final String dataUltimeSomministrazioni;

  @override
  GraphLinearUltimeSomministrazioniRegioni({
    this.typeinfo = "",
    this.labelText = "",
    this.iconpath = "",
    @required this.funTextInformation,
    @required this.funGetData,
    @required this.dataUltimeSomministrazioni,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width >= 400
        ? SVConst.kSizeIcons
        : SVConst.kSizeIconsSmall;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SVConst.radiusComponent),
      ),
      borderOnForeground: false,
      semanticContainer: false,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: iconSize,
                            width: iconSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              iconpath,
                              height: iconSize,
                              width: iconSize,
                            ),
                          ),
                          SizedBox(width: 25),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  labelText,
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                AutoSizeText(
                                  dataUltimeSomministrazioni,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: const Color(0xff379982),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Stack(
                          children: <Widget>[
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FutureBuilder(
                                      future: funTextInformation(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData)
                                          return CircularProgressIndicator();
                                        return AutoSizeText.rich(
                                          TextSpan(
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: snapshot.data + "\n",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 30,
                                                ),
                                              ),
                                              TextSpan(
                                                text: typeinfo,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                            AspectRatio(
                              aspectRatio: 1.5,
                              child: FutureBuilder(
                                  future: funGetData(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();
                                    return LineChart(
                                      LineChartData(
                                        gridData: FlGridData(show: false),
                                        borderData: FlBorderData(show: false),
                                        titlesData: FlTitlesData(show: false),
                                        lineTouchData: LineTouchData(
                                          touchTooltipData:
                                              LineTouchTooltipData(
                                                  getTooltipItems:
                                                      (List<LineBarSpot>
                                                          touchedBarSpots) {
                                            return touchedBarSpots
                                                .map((barSpot) {
                                              final flSpot = barSpot;
                                              final NumberFormat numberFormat =
                                                  NumberFormat.decimalPattern(
                                                      'it');
                                              String label = numberFormat
                                                      .format(flSpot.y) +
                                                  '\n';
                                              var formatter =
                                                  new DateFormat('dd/MM/yyyy');
                                              label += formatter.format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      (flSpot.x).toInt()));
                                              return LineTooltipItem(
                                                label,
                                                const TextStyle(
                                                  color: SVConst.mainColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }).toList();
                                          }),
                                        ),
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: snapshot.data,
                                            isCurved: false,
                                            dotData: FlDotData(show: false),
                                            colors: [SVConst.mainColor],
                                            belowBarData: BarAreaData(
                                              show: true,
                                              colors: [
                                                Colors.cyan.withAlpha(30)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
