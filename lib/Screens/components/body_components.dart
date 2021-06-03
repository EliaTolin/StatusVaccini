import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:statusvaccini/constants/constant.dart';

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

class LabelUltimeConsegne extends ChangeNotifier {
  LabelUltimeConsegne({this.str = "oggi"});
  String str;
  String get label => str;
  void setLabel(String value) {
    str = value;
  }

  notifyListeners();
}

class LabelUltimeSomministrazioni extends ChangeNotifier {
  LabelUltimeSomministrazioni({this.str = "oggi"});
  String str;
  String get label => str;
  void setLabel(String value) {
    str = value;
  }

  notifyListeners();
}

Column buildTopBarRegioni(Size size, String title, BuildContext context) {
  return Column(
    children: <Widget>[
      Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            height: size.height,
            decoration: BoxDecoration(
                color: SVConst.mainColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(SVConst.radiusComponent),
                )),
          ),
          Positioned(
            bottom: 15,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/arrow-back.svg",
                    height: SVConst.kSizeIcons,
                    width: SVConst.kSizeIcons,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  // width: 290,
                  alignment: Alignment.bottomCenter,
                  child: AutoSizeText(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 24,
                      color: SVConst.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

class TopBarRegioni extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Size size;
  final Function onPressed;
  final Function onTitleTapped;
  final Widget child;

  @override
  final Size preferredSize;

  TopBarRegioni(this.size,
      {@required this.title, this.child, this.onPressed, this.onTitleTapped})
      : preferredSize = Size.fromHeight(size.height * SVConst.kHeighBarRatio);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        height: preferredSize.height,
        child: buildTopBarRegioni(preferredSize, title, context));
  }
}
