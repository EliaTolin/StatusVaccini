// ignore: must_be_immutable
import 'package:statusvaccini/models/opendata.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:statusvaccini/screens/components/body_components.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Class for draw Card with Linear Card
// ignore: must_be_immutable
class GraphLinearUltimeSommistrazioni extends StatefulWidget {
  String typeinfo = "";
  String labelText = "";
  String iconpath = "";
  Function funTextInformation;
  Function funGetData;

  @override
  GraphLinearUltimeSommistrazioni({
    this.typeinfo,
    this.labelText,
    this.iconpath,
    this.funTextInformation,
    this.funGetData,
    Key key,
  }) : super(key: key);

  _GraphLinearUltimeSommistrazioniState createState() =>
      _GraphLinearUltimeSommistrazioniState();
}

// ignore: must_be_immutable
class _GraphLinearUltimeSommistrazioniState
    extends State<GraphLinearUltimeSommistrazioni> {
  //The information showed in the card
  String _textInformation = "NOT SET INFORMATION";
  //Flag for use ready Graph, all information are loaded
  bool _readyGraph = false;
  //Flag for use ready Text Information, all informatiomn are loaded
  bool _readyTextInformation = false;
  //List of FlSpot, are element of graph
  List<FlSpot> data = [];
  //If the receive data is old
  bool oldData = false;
  //InitState with preload data Information
  @override
  void initState() {
    super.initState();
    //GET INFORMATION
    getTextInformation();
    getInfoData();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SVConst.radiusComponent),
      ),
      borderOnForeground: false,
      semanticContainer: false,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {},
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                children: <Widget>[
                  cardContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Return if the all data are ready.
  bool ready() {
    return _readyGraph && _readyTextInformation;
  }

  Column cardContent() {
    final labelSommistrazioni = Provider.of<LabelUltimeSommistrazioni>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                height: SVConst.kSizeIcons,
                width: SVConst.kSizeIcons,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  widget.iconpath,
                  height: SVConst.kSizeIcons,
                  width: SVConst.kSizeIcons,
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
                      widget.labelText,
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
                      labelSommistrazioni.label,
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
        //If the data aren't ready, show wait status.
        ready() ? futureInformationContent() : waitFutureInformation(),
      ],
    );
  }

  //Draw the information when are ready
  Row futureInformationContent() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText.rich(
            TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: _textInformation + "\n",
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                  ),
                ),
                TextSpan(
                  text: widget.typeinfo,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: drawGraph(),
        ),
      ],
    );
  }

  //Show the wait status
  Column waitFutureInformation() {
    return Column(children: <Widget>[
      SizedBox(height: 40), // ELIA HACK, PER CENTRARE IL CARICAMENTO
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      )
    ]);
  }

  //Load graph if are ready.
  AspectRatio drawGraph() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                final NumberFormat numberFormat =
                    NumberFormat.decimalPattern('it');
                String label = numberFormat.format(flSpot.y) + '\n';
                var formatter = new DateFormat('dd/MM/yyyy');
                label += formatter.format(
                    DateTime.fromMillisecondsSinceEpoch((flSpot.x).toInt()));
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
              spots: data,
              isCurved: false,
              dotData: FlDotData(show: false),
              colors: [SVConst.mainColor],
              belowBarData: BarAreaData(
                show: true,
                colors: [Colors.cyan.withAlpha(30)],
              ),
            )
          ],
        ),
      ),
    );
  }

  //Load the text information.
  void getTextInformation() async {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('it');
    var tempValue;
    // DateTime now = DateTime.now();
    await widget.funTextInformation().then((value) => tempValue = value);

    bool isUltimeSommistrazioni =
        tempValue is UltimeSommistrazioni ? true : false;

    if (isUltimeSommistrazioni) {
      UltimeSommistrazioni ultimeSommistrazioni = tempValue;
      DateTime now = new DateTime.now();
      var formatter = new DateFormat('dd/MM/yyyy');
      if (now.difference(ultimeSommistrazioni.data).inDays != 0) {
        Provider.of<LabelUltimeSommistrazioni>(context, listen: false).setLabel(
            "il giorno " + formatter.format(ultimeSommistrazioni.data));
      }
      _textInformation = numberFormat.format(ultimeSommistrazioni.dosiTotali);
    } else {
      throw new Exception("The data is not UltimaSommistrazione");
    }
    setState(() {
      _readyTextInformation = true;
    });
  }

  //Load information for graph.
  void getInfoData() async {
    await widget.funGetData().then((value) => data = value);

    if (data != List.empty())
      setState(() {
        _readyGraph = true;
      });
  }
}
