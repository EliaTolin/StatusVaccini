//The class for items of legend
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color colorItem;
  final String textItem;
  final String dataValue;
  LegendItem(
      {this.colorItem, @required this.textItem, @required this.dataValue});
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
          Expanded(
            flex: 2,
            child: AutoSizeText(
              dataValue,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: Container(color: colorItem),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(width: 10),
          ),
          Expanded(
            flex: 3,
            child: AutoSizeText(
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

class InfoItem extends StatelessWidget {
  final Color colorItem;
  final String textItem;
  final String dataValue;
  InfoItem(
      {@required this.colorItem,
      @required this.textItem,
      @required this.dataValue});
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
          Expanded(
            flex: 2,
            child: AutoSizeText(
              textItem,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: colorItem,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(width: 10),
          ),
          Expanded(
            flex: 3,
            child: AutoSizeText(
              dataValue,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
