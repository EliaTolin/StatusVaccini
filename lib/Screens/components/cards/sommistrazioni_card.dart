// ignore: must_be_immutable
import 'package:statusvaccini/models/opendata.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:statusvaccini/screens/components/widgets/riga_variazione_widget.dart';

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
                      textAlign: TextAlign.start,
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
                      textAlign: TextAlign.start,
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
                        mapData: sommistrazioni,
                        startDate: now.subtract(new Duration(days: 1)),
                        label: "Ultimi due giorni",
                      ),
                      SizedBox(height: 20),
                      RigaVariazioneWidget(
                        mapData: sommistrazioni,
                        startDate: now.subtract(new Duration(days: 14)),
                        label: "Questa settimana rispetto alla scorsa",
                      ),
                      SizedBox(height: 20),
                      RigaVariazioneWidget(
                        mapData: sommistrazioni,
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