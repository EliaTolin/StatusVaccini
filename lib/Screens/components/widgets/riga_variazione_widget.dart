import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RigaVariazioneWidget extends StatefulWidget {
  final DateTime startDate;
  final String label;
  final Map<String, int> mapData;
  RigaVariazioneWidget({
    @required this.startDate,
    @required this.label,
    @required this.mapData,
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

      int consegneOggi;
      int consegneIeri;

      if (widget.mapData[today] == null) {
        today = formatter.format(now.subtract(new Duration(days: 1)));
        yesterday = formatter.format(now.subtract(new Duration(days: 2)));
      }

      consegneOggi = widget.mapData[today] != null ? widget.mapData[today] : 0;
      consegneIeri =
          widget.mapData[yesterday] != null ? widget.mapData[yesterday] : 0;

      if (consegneIeri != 0) {
        differenza = consegneOggi - consegneIeri;
        percentuale = (differenza * 100) / consegneIeri;
      } else {
        if (consegneOggi != 0) {
          differenza = consegneOggi;
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
        if (widget.mapData[dataB] != null) mediaB += widget.mapData[dataB];

        String dataA =
            formatter.format(widget.startDate.add(new Duration(days: i)));
        if (widget.mapData[dataA] != null) mediaA += widget.mapData[dataA];
      }

      mediaA /= (differenzaGiorni / 2);
      mediaB /= (differenzaGiorni / 2);
      differenza = (mediaB - mediaA).toInt();
      percentuale = (differenza * 100) / mediaA;
      percentuale = double.parse(percentuale.toStringAsFixed(2));
    }

    String labelPercentuale;
    String labelDifferenza;
    if (percentuale > 0) {
      up = true;
      labelPercentuale = "+" + percentuale.toString() + "%";
      labelDifferenza = "+" + differenza.toString();
    } else {
      up = false;
      labelPercentuale = percentuale.toString() + "%";
      labelDifferenza = differenza.toString();
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
                labelDifferenza,
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
