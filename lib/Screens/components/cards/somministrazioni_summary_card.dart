import 'package:statusvaccini/Models/opendata.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:statusvaccini/Models/repositories/data_information.dart';

class SomministrazioniSummaryCard extends StatefulWidget {
  final String labelText;
  final String iconpath;
  final String firstLabel;
  final String secondLabel;
  @override
  SomministrazioniSummaryCard({
    this.labelText = "",
    @required this.iconpath,
    @required this.firstLabel,
    @required this.secondLabel,
    Key key,
  }) : super(key: key);

  _SomministrazioniSummaryCardState createState() =>
      _SomministrazioniSummaryCardState();
}

class _SomministrazioniSummaryCardState
    extends State<SomministrazioniSummaryCard> {
  //Flag for use ready information, all information are loaded
  bool _readyInformation = false;
  //List of FlSpot, are element of graph
  double sizeListView = 200;
  //Total of first somministration
  int primeDosi = -1;
  //Total of second somministration
  int secondeDosi = -1;
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
    var expanded = Column(
      children: [
        //HEADER WITH TITLE AND SUBTITLE
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ready() ? buildContenent() : waitFutureInformation(),
          ],
        )
        //CONTENT OF BOX
      ],
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SVConst.radiusComponent),
      ),
      borderOnForeground: false,
      semanticContainer: false,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: expanded,
      ),
    );
  }

  String getPercentuale(int valore) {
    String value = "";
    double percentuale = (valore * 100) / DataInformation.popolazioneItalia;
    percentuale = double.parse((percentuale.toStringAsFixed(2)));
    value = percentuale.toString() + " % ";
    return value;
  }

  Container buildContenent() {
    final NumberFormat numberFormat = NumberFormat.decimalPattern('it');
    return Container(
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                    numberFormat.format(primeDosi),
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
                          text: getPercentuale(primeDosi),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                ],
              ),
            ),
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
                    "Seconde dosi",
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: const Color(0xff379982),
                    ),
                  ),
                  SizedBox(width: 10),
                  AutoSizeText(
                    numberFormat.format(secondeDosi),
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
                          text: getPercentuale(secondeDosi),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                ],
              ),
            ),
          ),
        ],
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
    await OpenData.getTotalePrimeDosi().then((value) => primeDosi = value);

    await OpenData.getTotaleSecondiDosi().then((value) => secondeDosi = value);

    if (primeDosi != -1 && secondeDosi != -1)
      setState(() {
        _readyInformation = true;
      });
  }
}
