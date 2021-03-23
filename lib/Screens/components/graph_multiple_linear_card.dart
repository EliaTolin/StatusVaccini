// ignore: must_be_immutable
import 'package:StatusVaccini/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

//Class for draw Card with Linear Card
// ignore: must_be_immutable
class GraphMultipleLinearCard extends StatefulWidget {
  String typeinfo = "";
  String labelText = "";
  String iconpath = "";
  List<Function> funGetData;
  List<Function> funTextInformation;

  @override
  GraphMultipleLinearCard({
    this.typeinfo,
    this.labelText,
    this.iconpath,
    this.funGetData,
    Key key,
  }) : super(key: key);

  _GraphMultipleLinearCardState createState() =>
      _GraphMultipleLinearCardState();
}

// ignore: must_be_immutable
class _GraphMultipleLinearCardState extends State<GraphMultipleLinearCard> {
  //Flag for use ready Graph, all information are loaded
  bool _readyGraph = false;
  //List of FlSpot, are element of graph
  List<dynamic> data = [];

  //InitState with preload data Information
  @override
  void initState() {
    super.initState();
    //GET INFORMATION
    //getTextInformation();
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
    return _readyGraph;
  }

  Column cardContent() {
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
                  //color: SVConst.iconColor,
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
                child: AutoSizeText(
                  widget.labelText.toString(),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
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
  Container futureInformationContent() {
    return Container(
      child: drawGraph(),
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
          lineBarsData: getChartBarData(),
        ),
      ),
    );
  }

  List<LineChartBarData> getChartBarData() {
    List<LineChartBarData> list = [];
    for (int i = 0; i < widget.funGetData.length; i++) {
      list.add(
        LineChartBarData(
          spots: data[i],
          isCurved: true,
          dotData: FlDotData(show: false),
          //belowBarData: BarAreaData(show: false),
          colors: [SVConst.linearColors[i]],
          belowBarData: BarAreaData(
            show: true,
            colors: [SVConst.linearColors[i].withAlpha(30)],
          ),
        ),
      );
    }
    return list;
  }

  //Load information for graph.
  void getInfoData() async {
    for (int i = 0; i < widget.funGetData.length; i++) {
      await widget.funGetData[i]().then((value) => data.add(value));
    }

    if (data != List.empty())
      setState(() {
        _readyGraph = true;
      });
  }
}
