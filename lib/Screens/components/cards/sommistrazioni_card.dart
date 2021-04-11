// ignore: must_be_immutable
import 'package:statusvaccini/models/opendata.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

//Class for draw Card with Linear Card
// ignore: must_be_immutable
class SommistrazioniCard extends StatefulWidget {
  String labelText = "";
  String iconpath = "";
  String firstLabel;
  String secondLabel;
  @override
  SommistrazioniCard({
    this.labelText,
    this.iconpath,
    this.firstLabel,
    this.secondLabel,
    Key key,
  }) : super(key: key);

  _SommistrazioniCardState createState() => _SommistrazioniCardState();
}

// ignore: must_be_immutable
class _SommistrazioniCardState extends State<SommistrazioniCard> {
  //Flag for use ready Graph, all information are loaded
  bool _readyInformation = false;
  //List of FlSpot, are element of graph
  double sizeListView = 200;
  //Map for sommistration
  Map<String, int> sommistrazioni = new Map<String, int>();
  //Get date
  DateTime now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    //GET DATA INFORMATION
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // HEADER WITH TITLE AND SUBTITLE
            Row(
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
                        widget.firstLabel,
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
                        widget.secondLabel,
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
            //CONTENT OF BOX
            SizedBox(height: 30),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Riferimento temporale",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Differenza",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Variazione percentuale",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ready()
                ? Column(
                    children: [
                      RigaVariazioneWidget(
                        data: sommistrazioni,
                        startDate: now.subtract(new Duration(days: 1)),
                        label: "Ultimi due giorni",
                      ),
                      SizedBox(height: 20),
                      RigaVariazioneWidget(
                        data: sommistrazioni,
                        startDate: now.subtract(new Duration(days: 14)),
                        label: "Questa settimana rispetto alla scorsa",
                      ),
                      SizedBox(height: 20),
                      RigaVariazioneWidget(
                        data: sommistrazioni,
                        startDate: now.subtract(new Duration(days: 31)),
                        label: "Questo mese rispetto allo scorso",
                      ),
                      SizedBox(height: 20),
                    ],
                  )
                : waitFutureInformation(),
          ],
        ),
      ),
    );
  }

  //Return if the all data are ready.
  bool ready() {
    return _readyInformation;
  }

  //Show the wait status
  Column waitFutureInformation() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          )
        ]);
  }

  //Load information for graph.
  void getInfoData() async {
    await OpenData.getSommistrazioniPerGiorno()
        .then((value) => sommistrazioni = value);

    if (sommistrazioni.isNotEmpty)
      setState(() {
        _readyInformation = true;
      });
  }
}

class RigaVariazioneWidget extends StatefulWidget {
  final DateTime startDate;
  final String label;
  final Map<String, int> data;
  RigaVariazioneWidget({
    @required this.startDate,
    @required this.label,
    @required this.data,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RigaVariazioneState();
}

class _RigaVariazioneState extends State<RigaVariazioneWidget> {
  bool up = false;
  double percentuale = 0;
  var formatter = new DateFormat('yyyy-MM-dd');
  int differenza = 0;
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime startDate = widget.startDate;
    if (now.difference(startDate).inDays == 0)
      throw new Exception("The difference is 0 from start and end date");

    if (now.difference(startDate).inDays == 1) {
      String today = formatter.format(now);
      String yesterday = formatter.format(now.subtract(new Duration(days: 1)));

      int sommistrazioniOggi;
      int sommistrazioniIeri;

      if (widget.data[today] == null) {
        today = formatter.format(now.subtract(new Duration(days: 1)));
        yesterday = formatter.format(now.subtract(new Duration(days: 2)));
      }

      sommistrazioniOggi = widget.data[today] != null ? widget.data[today] : 0;
      sommistrazioniIeri =
          widget.data[yesterday] != null ? widget.data[yesterday] : 0;

      if (sommistrazioniIeri != 0) {
        differenza = sommistrazioniOggi - sommistrazioniIeri;
        percentuale = (differenza * 100) / sommistrazioniIeri;
      } else {
        if (sommistrazioniOggi != 0) {
          differenza = sommistrazioniOggi;
          percentuale = 100;
        } else {
          percentuale = 0;
          differenza = 0;
        }
      }
      percentuale = double.parse(percentuale.toStringAsFixed(2));
    } else {
      if ((now.difference(widget.startDate).inDays % 2) != 0) {
        startDate = startDate.add(new Duration(days: 1));
      }
      int differenzaGiorni = now.difference(startDate).inDays;
      double mediaA = 0;
      double mediaB = 0;
      for (int i = 0; i < (differenzaGiorni / 2); i++) {
        String dataB = formatter.format(now.subtract(new Duration(days: i)));
        if (widget.data[dataB] != null) mediaB += widget.data[dataB];

        String dataA =
            formatter.format(widget.startDate.add(new Duration(days: i)));
        if (widget.data[dataA] != null) mediaA += widget.data[dataA];
      }

      mediaA /= (differenzaGiorni / 2);
      mediaB /= (differenzaGiorni / 2);
      differenza = (mediaB - mediaA).toInt();
      percentuale = (differenza * 100) / mediaA;
      percentuale = double.parse(percentuale.toStringAsFixed(2));
    }

    String labelPercentuale;
    if (percentuale > 0) {
      up = true;
      labelPercentuale = "+" + percentuale.toString() + "%";
    } else {
      up = false;
      labelPercentuale = percentuale.toString() + "%";
    }

    return Container(
      decoration: up
          ? BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade100,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            )
          : BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.shade100,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: AutoSizeText(
                widget.label,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: AutoSizeText(
                differenza.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: AutoSizeText(
                labelPercentuale,
                textAlign: TextAlign.center,
                style: up
                    ? TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                    : TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
