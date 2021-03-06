import 'package:statusvaccini/constants/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:statusvaccini/Models/opendata.dart';
import 'package:intl/intl.dart';
import 'package:statusvaccini/Screens/components/widgets/information_item.dart';

//Class for draw Card with Pie Chart

class GraphPieCard extends StatefulWidget {
  final String typeinfo;
  final String labelText;
  final String iconpath;
  final Function funTextInformation;
  final Function funGetData;

  @override
  GraphPieCard({
    this.typeinfo = "",
    this.labelText = "",
    this.iconpath = "",
    @required this.funTextInformation,
    @required this.funGetData,
    Key key,
  }) : super(key: key);

  _GraphPieCardState createState() => _GraphPieCardState();
}

class _GraphPieCardState extends State<GraphPieCard> {
  //Flag use for ready information, all information are loaded
  bool _readyGraph = false;
  //Used for the chart select event. Indicates the selected part
  int touchedIndex;
  //List with all providers
  List<Fornitore> data = [];
  //List with section of PieChart
  List<LegendItem> sectionPieList = [];

  //InitState with preload data Information
  @override
  void initState() {
    super.initState();
    //GET INFORMATION
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
            child: cardContent(),
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
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  widget.iconpath, // ICON OF CARD
                  height: iconSize,
                  width: iconSize,
                ),
              ),
              SizedBox(width: 25),
              Flexible(
                fit: FlexFit.tight,
                child: AutoSizeText(
                  widget.labelText.toString(),
                  textAlign: TextAlign.end,
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
        ready() ? drawGraph() : waitFutureInformation(), //DRAW GRAPH
        ready() ? drawLegend() : Container(), //DRAW LEGEND
      ],
    );
  }

  //Draw the legend of graph
  Padding drawLegend() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          for (final section in sectionPieList) section,
        ],
      ),
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

  //Draw Pie Chart
  AspectRatio drawGraph() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: PieChart(
        PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (pieTouchResponse) {
                setState(() {
                  if (pieTouchResponse.touchInput is FlLongPressEnd ||
                      pieTouchResponse.touchInput is FlPanEnd) {
                    touchedIndex = -1;
                  } else {
                    touchedIndex = pieTouchResponse.touchedSectionIndex;
                  }
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: showingSections()),
      ),
    );
  }

  //Create the sections of the graph.
  //Return the list of sections
  List<PieChartSectionData> showingSections() {
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      final Color textColor = isTouched ? Colors.white : Color(0x00);
      final Color backgroundColor =
          isTouched ? SVConst.listColors[i] : Color(0x00);
      final NumberFormat numberFormat = NumberFormat.decimalPattern('it');

      return PieChartSectionData(
        color: SVConst.listColors[i],
        value: data[i].percentualeSuTot,
        title: numberFormat.format(data[i].numeroDosi),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
          backgroundColor: backgroundColor,
        ),
      );
    });
  }

  //Method for get information from OpenData
  void getInfoData() async {
    await OpenData.getDosiPerFornitore().then((value) => data = value);
    loadSection();
    if (data != List.empty())
      setState(() {
        _readyGraph = true;
      });
  }

  void loadSection() {
    int i = 0;
    data.forEach((element) {
      sectionPieList.add(LegendItem(
        dataValue: element.percentualeSuTot.toString() + "%",
        textItem: element.nome,
        colorItem: SVConst.listColors[i],
      ));
      i++;
    });
  }
}
