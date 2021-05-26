import 'package:statusvaccini/constants/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

//Class for draw Card with Linear Card

class GraphBarCard extends StatefulWidget {
  final String labelText;
  final String iconpath;
  final String secondLabelText;
  final Function funGetData;

  @override
  GraphBarCard({
    this.labelText = "",
    this.secondLabelText = "",
    this.iconpath = "",
    @required this.funGetData,
    Key key,
  }) : super(key: key);

  _GraphBarCardState createState() => _GraphBarCardState();
}

class _GraphBarCardState extends State<GraphBarCard> {
  //Flag for use ready Graph, all information are loaded
  bool _readyGraph = false;
  //Map  of information about y.o. range
  Map<String, int> data = new Map<String, int>();

  final Duration animDuration = const Duration(milliseconds: 250);
  int dosiTotali = 0;
  int touchedIndex;

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
    double iconSize = MediaQuery.of(context).size.width >= 400
        ? SVConst.kSizeIcons
        : SVConst.kSizeIconsSmall;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                height: iconSize,
                width: iconSize,
                decoration: BoxDecoration(
                  //color: SVConst.iconColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  widget.iconpath,
                  height: iconSize,
                  width: iconSize,
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
                      maxLines: 1,
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
                      widget.secondLabelText,
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
        ready() ? drawGraph() : waitFutureInformation(),
      ],
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
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched
              ? [SVConst.itemSelectedBarColor]
              : [SVConst.itemBarColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [SVConst.itemBackBarColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> list = [];
    int i = 0;
    data.forEach((key, value) {
      list.add(
          makeGroupData(i, value.toDouble(), isTouched: i == touchedIndex));
      i++;
    });
    return list;
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: SVConst.tooltipDataBarColor,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              //RITORNA IL RANGE D'ETA PER LA DATATIP
              String rangeEta;
              rangeEta = data.keys.elementAt(group.x.toInt());
              var tmp = (rod.y - 1).toString().split('.');
              int dosi = int.parse(tmp[0]);
              final NumberFormat numberFormat =
                  NumberFormat.decimalPattern('it');

              double percentuale =
                  double.parse(((dosi * 100) / dosiTotali).toStringAsFixed(2));

              String textContent = rangeEta +
                  '\n' +
                  numberFormat.format(dosi) +
                  '\n' +
                  percentuale.toString() +
                  "%";
              return BarTooltipItem(
                  textContent,
                  TextStyle(
                      fontSize: 15,
                      color: SVConst.textItemBarColor,
                      fontWeight: FontWeight.bold));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: SVConst.textBarColor,
              fontWeight: FontWeight.bold,
              fontSize: 15),
          margin: 16,
          //RITORNA I TITOLI SOTTO LE BARRE
          getTitles: (value) {
            String element = "";
            element = data.keys.elementAt(value.toInt());
            element = element.substring(0, 2);
            return element;
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  //Load information for graph.
  void getInfoData() async {
    await widget.funGetData().then((value) => data = value);

    if (data.isNotEmpty) {
      setState(() {
        _readyGraph = true;
      });
      data.forEach((key, value) {
        dosiTotali += value;
      });
    }
  }
}
