import 'package:statusvaccini/Models/opendata.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:statusvaccini/Models/repositories/data_information.dart';

//Class for draw Card with Linear Card
class RecordCard extends StatefulWidget {
  @override
  RecordCard({
    Key key,
  }) : super(key: key);

  _RecordCardState createState() => _RecordCardState();
}

class _RecordCardState extends State<RecordCard> {
  //Flag for use ready information, all information are loaded
  bool _readyInformation = false;
  //Map with record of somministrazion
  Map<String, int> recordSomministrazioni;
  //Map with record of delivery
  Map<String, int> recordConsegne;
  //Get date
  DateTime now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    //GET DATA INFORMATION
    getInfoData();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    var expanded = Column(
      children: [
        //HEADER WITH TITLE AND SUBTITLE
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ready() ? buildContenent() : waitFutureInformation(),
            ),
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
    DateTime tempDate;
    //Refactoring date for delivery
    String dataConsegne;
    tempDate = DateTime.parse(recordConsegne.keys.toList()[0]);
    dataConsegne = tempDate.day.toString() +
        "/" +
        tempDate.month.toString() +
        "/" +
        tempDate.year.toString();

    //Refactoring darte for somministration
    String dataSomministrazioni;
    tempDate = DateTime.parse(recordSomministrazioni.keys.toList()[0]);
    dataSomministrazioni = tempDate.day.toString() +
        "/" +
        tempDate.month.toString() +
        "/" +
        tempDate.year.toString();

    return Container(
      child: Column(
        children: [
          //RECORD SOMMINISTRAZIONI
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  "Record somministrazioni",
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: const Color(0xff379982),
                  ),
                ),
                SizedBox(width: 10),
                AutoSizeText(
                  numberFormat.format(
                    recordSomministrazioni.values.toList()[0],
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10),
                AutoSizeText.rich(
                  TextSpan(
                    text: 'il giorno ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: dataSomministrazioni,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //RECORD CONSEGNE
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "Record consegne",
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: const Color(0xff379982),
                    ),
                  ),
                  SizedBox(width: 10),
                  AutoSizeText(
                    numberFormat.format(
                      recordConsegne.values.toList()[0],
                    ),
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
                          text: 'il giorno ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: dataConsegne,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        maxLines: 1,
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
      ],
    );
  }

  //Load information for card
  void getInfoData() async {
    await OpenData.getRecordSomministrazioni()
        .then((value) => recordSomministrazioni = value);

    await OpenData.getRecordConsegne().then((value) => recordConsegne = value);

    if (recordSomministrazioni.isNotEmpty && recordConsegne.isNotEmpty)
      setState(() {
        _readyInformation = true;
      });
  }
}
