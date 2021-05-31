import 'package:statusvaccini/Models/opendata.dart';
import 'package:statusvaccini/Models/repositories/data_information.dart';
import 'package:statusvaccini/Screens/views/region_details.dart';
import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
      list.add(InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => RegionDetailsView(element))),
        child: ElementBox(
          index: i,
          nameItem: nome,
          heightElement: sizeListView,
        ),
      ));
      i++;
    }

    //DRAW THE LISTBOX
    return Container(
      height: sizeListView + 100,
      // decoration: BoxDecoration(
      //     color: SVConst.cardColor, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: ListView(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.vertical,
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
    @required this.nameItem,
    @required this.heightElement,
  }) : super(key: key);

  final int index;
  final String nameItem;
  final double heightElement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
        top: 8.0,
        left: 10,
        right: 10,
      ),
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
        // height: heightElement,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // DataInformation.sigleRegioni[nameItem],
              //SVConst.circularItemsColors[index],
              Container(
                child: AutoSizeText(
                  DataInformation.sigleRegioni[nameItem],
                  maxLines: 1,
                  style: TextStyle(
                    color: SVConst.circularItemsColors[index],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SvgPicture.asset(
              //   "assets/icons/arrow-back.svg",
              //   color: Colors.black,
              //   height:
              // ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
