// ignore: must_be_immutable
import 'package:statusvaccini/constants/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

//Class for draw Card with Linear Card
// ignore: must_be_immutable
class GraphMultipleLinearCard extends StatefulWidget {
  String typeinfo = "";
  String labelText = "";
  String iconpath = "";
  List<Function> funGetData = [];
  List<String> textLegends = [];
  @override
  GraphMultipleLinearCard({
    this.typeinfo,
    this.labelText,
    this.iconpath,
    this.funGetData,
    this.textLegends,
    Key key,
  }) : super(key: key) {
    if (funGetData.length != textLegends.length)
      throw new Exception(
          "Error lenght different for element in the graph and legend labels" +
              runtimeType.toString());
  }

  _GraphMultipleLinearCardState createState() =>
      _GraphMultipleLinearCardState();
}

// ignore: must_be_immutable
class _GraphMultipleLinearCardState extends State<GraphMultipleLinearCard> {
  //Flag for use ready Graph, all information are loaded
  bool _readyGraph = false;
  //List of FlSpot, are element of graph
  List<dynamic> data = [];
  //Legend of chart
  List<ChartItem> chartItemList = [];
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
        ready()
            ? Stack(
                children: <Widget>[
                  //If the data aren't ready, show wait status.
                  futureInformationContent(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [chartItemList[0], chartItemList[1]],
                    ),
                  )
                ],
              )
            : waitFutureInformation(),
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
              bool firstElement = true;
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                final NumberFormat numberFormat =
                    NumberFormat.decimalPattern('it');
                String label = "";
                if (firstElement) {
                  var formatter = new DateFormat('dd/MM/yyyy');
                  label = formatter.format(
                      DateTime.fromMillisecondsSinceEpoch((flSpot.x).toInt()));
                  label = label + '\n';
                  firstElement = false;
                }
                label = label + numberFormat.format(flSpot.y);
                final Color color = flSpot.bar.colors[0];
                return LineTooltipItem(
                  label,
                  TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            }),
          ),
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
        loadSection();
      });
  }

  //Load the legend of graph
  void loadSection() {
    for (int i = 0; i < widget.textLegends.length; i++) {
      chartItemList.add(ChartItem(
        textItem: widget.textLegends[i],
        colorItem: SVConst.linearColors[i],
      ));
    }
  }
}

//The class for items of legend
class ChartItem extends StatelessWidget {
  final Color colorItem;
  final String textItem;
  ChartItem({
    this.colorItem,
    @required this.textItem,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
            child: Container(color: colorItem),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Text(
              textItem,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
