import 'package:statusvaccini/Models/opendata.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UltimoAggiornamentoCard extends StatefulWidget {
  @override
  UltimoAggiornamentoCard({
    Key key,
  }) : super(key: key);

  _UltimoAggiornamentoCardState createState() =>
      _UltimoAggiornamentoCardState();
}

class _UltimoAggiornamentoCardState extends State<UltimoAggiornamentoCard> {
  //Flag for use ready Text Information, all informatiomn are loaded
  bool _readyTextInformation = false;
  DateTime ultimoAggiornamento;

  //InitState with preload data Information
  @override
  void initState() {
    super.initState();
    //GET INFORMATION
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
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Wrap(
            children: <Widget>[
              cardContent(),
            ],
          ),
        ),
      ),
    );
  }

  //Return if the all data are ready.
  bool ready() {
    return _readyTextInformation;
  }

  Column cardContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //If the data aren't ready, show wait status.
        ready() ? futureInformationContent() : waitFutureInformation(),
      ],
    );
  }

  //Draw the information when are ready
  Row futureInformationContent() {
    String giorno = "";
    DateTime now = DateTime.now();
    if (now.day == ultimoAggiornamento.day &&
        now.month == ultimoAggiornamento.month &&
        now.year == ultimoAggiornamento.year) {
      giorno = " di oggi";
    } else {
      giorno = " del giorno " +
          ultimoAggiornamento.day.toString() +
          "/" +
          ultimoAggiornamento.month.toString() +
          "/" +
          ultimoAggiornamento.year.toString();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText.rich(
              TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: "Ultimo aggiornamento dei dati alle ore\n",
                  ),
                  TextSpan(
                      text: ultimoAggiornamento.hour.toString() +
                          ":" +
                          ultimoAggiornamento.minute.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text: giorno,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
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

  //Load information for graph.
  void getInfoData() async {
    await OpenData.getLastUpdateData()
        .then((value) => ultimoAggiornamento = value);

    if (ultimoAggiornamento != null)
      setState(() {
        _readyTextInformation = true;
      });
  }
}
