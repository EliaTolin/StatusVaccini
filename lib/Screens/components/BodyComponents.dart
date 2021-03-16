import 'package:flutter/material.dart';
import 'package:StatusVaccini/constant.dart';

Column buildTopBar(Size size, String title) {
  return Column(
    children: <Widget>[
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: size.height * SVConst.kHeighBarRatio,
            decoration: BoxDecoration(
                color: SVConst.topbarColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(SVConst.radiusComponent),
                  bottomRight: Radius.circular(SVConst.radiusComponent),
                )),
          ),
          Positioned(
            bottom: 15,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  color: SVConst.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    ],
  );
}
