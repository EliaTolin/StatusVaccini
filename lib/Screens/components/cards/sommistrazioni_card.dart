// ignore: must_be_immutable
import 'package:statusvaccini/models/opendata.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

//Class for draw Card with Linear Card
// ignore: must_be_immutable
class SommistrazioniCard extends StatefulWidget {
  String labelText = "";
  String iconpath = "";
  Function funGetData;
  String firstLabel;
  String secondLabel;
  @override
  SommistrazioniCard({
    this.labelText,
    this.iconpath,
    this.funGetData,
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
  List<Regione> data;
  //Size of element in listview
  double sizeListView = 200;
  //InitState with preload data Information
  @override
  void initState() {
    super.initState();
    //GET DATA INFORMATION
    //getInfoData();
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Valore in relazione alle medie",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Variazione percentuale",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            RigaVariazioneWidget(
              startDate: new DateTime.now(),
              endDate: new DateTime.now(),
              label: "PIPPO",
            ),

            SizedBox(height: 30),
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
    await widget.funGetData().then((value) => data = value);

    if (data.isNotEmpty)
      setState(() {
        _readyInformation = true;
      });
  }
}

class RigaVariazioneWidget extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String label;
  RigaVariazioneWidget({
    @required this.startDate,
    @required this.endDate,
    @required this.label,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RigaVariazioneState();
}

class _RigaVariazioneState extends State<RigaVariazioneWidget> {
  bool up = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: AutoSizeText(
              widget.label,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: AutoSizeText(
              "1432325",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                up
                    ? SvgPicture.asset(
                        "assets/icons/down-arrow.svg",
                        height: 30,
                        color: Colors.red,
                      )
                    : SvgPicture.asset(
                        "assets/icons/up-arrow.svg",
                        height: 30,
                        color: Colors.green,
                      ),
                AutoSizeText(
                  "-30%",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
