import 'package:statusvaccini/Models/opendata.dart';
import 'package:statusvaccini/Models/repositories/data_information.dart';
import 'package:statusvaccini/Screens/views/region_details.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

//Class for draw Card with Linear Card

class CardViewRegioni extends StatefulWidget {
  final String labelText;
  final String iconpath;
  final Function funGetData;
  final String firstLabel;
  final String secondLabel;
  @override
  CardViewRegioni({
    @required this.labelText,
    @required this.iconpath,
    @required this.funGetData,
    @required this.firstLabel,
    @required this.secondLabel,
    Key key,
  }) : super(key: key);

  _CardViewRegioniState createState() => _CardViewRegioniState();
}

class _CardViewRegioniState extends State<CardViewRegioni> {
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
    getInfoData();
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width >= 400
        ? SVConst.kSizeIcons
        : SVConst.kSizeIconsSmall;
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
                  height: iconSize,
                  width: iconSize,
                  decoration: BoxDecoration(
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
            ready() ? buildBoxContent() : waitFutureInformation(),
          ],
        ),
      ),
    );
  }

  //Return if the all data are ready.
  bool ready() {
    return _readyInformation;
  }

  Container buildBoxContent() {
    if (data.length == 0)
      throw new Exception("Data is empty" + runtimeType.toString());

    List<Widget> list = [];
    int i = 0;

    data.sort((a, b) => a.nome.compareTo(b.nome));
    for (Regione element in data) {
      String nome = element.sigla;

      double percTot = ((element.totaleDosiSommistrate * 100) /
          DataInformation.abitantiRegioni[element.sigla]);

      double percPrimaDose = ((element.primeDosi * 100) /
          DataInformation.abitantiRegioni[element.sigla]);

      double percSecondaDose = ((element.secondeDosi * 100) /
          DataInformation.abitantiRegioni[element.sigla]);

      list.add(InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => RegionDetailsView(element))),
        child: ElementBox(
          index: i,
          percentualeTot: double.parse(percTot.toStringAsFixed(2)),
          nameItem: nome,
          heightElement: sizeListView,
          percentualePrimeDosi: double.parse(percPrimaDose.toStringAsFixed(2)),
          percentualeSecondeDosi:
              double.parse(percSecondaDose.toStringAsFixed(2)),
        ),
      ));
      i++;
    }

    //DRAW THE LISTBOX
    return Container(
      height: sizeListView + 100,
      decoration: BoxDecoration(
          color: SVConst.cardColor, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.horizontal,
          children: list,
        ),
      ),
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

  //Load information for graph.
  void getInfoData() async {
    await widget.funGetData().then((value) => data = value);

    if (data.isNotEmpty)
      setState(() {
        _readyInformation = true;
      });
  }
}

class ElementBox extends StatelessWidget {
  const ElementBox({
    Key key,
    @required this.index,
    @required this.percentualeTot,
    @required this.nameItem,
    @required this.heightElement,
    @required this.percentualePrimeDosi,
    @required this.percentualeSecondeDosi,
  }) : super(key: key);

  final int index;
  final double percentualeTot;
  final String nameItem;
  final double heightElement;
  final double percentualePrimeDosi;
  final double percentualeSecondeDosi;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 18.0, right: 18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: SVConst.circularItemsColors[index].withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: heightElement,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: heightElement * 0.7,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Center(
                    child: CircularPercentIndicator(
                      backgroundColor: Colors.white,
                      radius: 120.0,
                      lineWidth: 13.0,
                      percent: (percentualeTot / 100),
                      center: Text(
                        percentualeTot.toString() + "%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      footer: Container(
                        child: AutoSizeText(
                          DataInformation.sigleRegioni[nameItem],
                          maxLines: 1,
                          style: TextStyle(
                              color: SVConst.circularItemsColors[index],
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: SVConst.circularItemsColors[index],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "Prima dose : ",
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        AutoSizeText(
                          percentualePrimeDosi.toString() + "%",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AutoSizeText(
                          "Seconda dose : ",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AutoSizeText(
                          percentualeSecondeDosi.toString() + "%",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
