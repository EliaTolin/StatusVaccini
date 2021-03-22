// ignore: must_be_immutable
import 'package:StatusVaccini/Models/consegne_vaccini_latest.dart';
import 'package:StatusVaccini/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:StatusVaccini/Models/opendata.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class GraphPieCard extends StatefulWidget {
  String typeinfo = "";
  String labelText = "";
  String iconpath = "";
  Function funTextInformation;
  Function funGetData;

  @override
  GraphPieCard({
    this.typeinfo,
    this.labelText,
    this.iconpath,
    this.funTextInformation,
    this.funGetData,
    Key key,
  }) : super(key: key);

  _GraphPieCardState createState() => _GraphPieCardState();
}

// ignore: must_be_immutable
class _GraphPieCardState extends State<GraphPieCard> {
  String _textInformation = "NOT SET INFORMATION";
  bool _readyGraph = false;
  bool _readyTextInformation = false;
  int touchedIndex;
  List<Fornitore> data = [];
  List<PieItem> sectionPieList = [];

  @override
  void initState() {
    super.initState();
    //GET INFORMATION
    getTextInformation();
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
            child: cardContent(),
          ),
        ),
      ),
    );
  }

  bool ready() {
    return _readyGraph && _readyTextInformation;
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
        ready() ? drawGraph() : waitFutureInformation(),
        ready() ? drawSection() : waitFutureInformation(),
      ],
    );
  }

  Padding drawSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final section in sectionPieList) section,
          ],
        ),
      ),
    );
  }

  Column waitFutureInformation() {
    return Column(children: <Widget>[
      SizedBox(height: 40), // ELIA HACK, PER CENTRARE IL CARICAMENTO
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    ]);
  }

  void getTextInformation() async {
    await widget
        .funTextInformation()
        .then((value) => _textInformation = value.toString());
    setState(() {
      _readyTextInformation = true;
    });
  }

  AspectRatio drawGraph() {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
            pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
              setState(() {
                if (pieTouchResponse.touchInput is FlLongPressEnd ||
                    pieTouchResponse.touchInput is FlPanEnd) {
                  touchedIndex = -1;
                } else {
                  touchedIndex = pieTouchResponse.touchedSectionIndex;
                }
              });
            }),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: showingSections()),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      final Color textColor = isTouched ? Color(0xff000000) : Color(0x00);
      return PieChartSectionData(
        color: SVConst.pieColors[i],
        value: data[i].percentualeSuTot,
        title: data[i].percentualeSuTot.toString() + "%",
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          // color: const Color(0xffffffff)),
          color: textColor,
        ),
      );
    });
  }

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
      sectionPieList.add(PieItem(
        percentuale: element.percentualeSuTot.toString() + "%",
        textItem: element.nome,
        colorItem: SVConst.pieColors[i],
      ));
      i++;
    });
  }
}

class PieItem extends StatelessWidget {
  final Color colorItem;
  final String textItem;
  final String percentuale;
  PieItem(
      {this.colorItem, @required this.textItem, @required this.percentuale});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: <Widget>[
          Text(
            percentuale,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 20,
            height: 20,
            child: Container(color: colorItem),
          ),
          SizedBox(width: 10),
          Text(
            textItem,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
