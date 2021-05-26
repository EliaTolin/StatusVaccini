import 'package:statusvaccini/constants/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:statusvaccini/Screens/components/body_components.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoView extends StatefulWidget {
  @override
  _InfoViewState createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TopBar(size, title: SVConst.titleAppBar),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                buildCardContact(),
                buildCardOpenSource(),
                buildCardGit(),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ));
  }

  Card buildCardContact() {
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
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Contatti",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: SVConst.listColors[0],
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      AutoSizeText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    "Per problematiche, consigli e informazioni: \n"),
                            TextSpan(
                              text: "mail@eliatolin.it",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card buildCardOpenSource() {
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
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Open Source",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: SVConst.listColors[4],
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      AutoSizeText.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    "Status Vaccini è Open Source, cioè il codice con cui è stata scritta l'applicazione è libero e fruibile a tutti."),
                          ],
                        ),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 25),
                Container(
                  height: iconSize,
                  width: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/guide.svg",
                    height: iconSize,
                    width: iconSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildCardGit() {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () async {
        const url = 'https://github.com/EliaTolin/StatusVaccini';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Card(
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
                  // SizedBox(width: 25),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "GitHub",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: SVConst.listColors[3],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        AutoSizeText.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      "Il codice sorgente è disponibile nel repository GitHub.\nClicca  sull'icona \"Git\" per accederci."),
                            ],
                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      iconSize: 100,
                      icon: SvgPicture.asset(
                        "assets/icons/git.svg",
                      ),
                      onPressed: () async {
                        const url =
                            'https://github.com/EliaTolin/StatusVaccini';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
