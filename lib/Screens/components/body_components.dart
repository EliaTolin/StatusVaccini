import 'package:flutter/material.dart';
import 'package:StatusVaccini/constant.dart';

Column buildTopBar(Size size, String title) {
  return Column(
    children: <Widget>[
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: size.height,
            decoration: BoxDecoration(
                color: SVConst.mainColor,
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

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Size size;
  final Function onPressed;
  final Function onTitleTapped;
  final Widget child;

  @override
  final Size preferredSize;

  TopBar(this.size,
      {@required this.title, this.child, this.onPressed, this.onTitleTapped})
      : preferredSize = Size.fromHeight(size.height * SVConst.kHeighBarRatio);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: preferredSize.height,
        child: buildTopBar(preferredSize, title));
  }
}
