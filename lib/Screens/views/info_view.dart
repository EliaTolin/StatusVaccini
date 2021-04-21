import 'package:statusvaccini/constants/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:statusvaccini/screens/components/body_components.dart';
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
                buildCardOpenSource(),
                InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () async {
                    const url = 'https://github.com/EliaTolin/StatusVaccini';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: buildCardGit(),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ));
  }

  Card buildCardGit() {
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
                    // height: SVConst.kSizeIcons,
                    // width: SVConst.kSizeIcons,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        iconSize: 100,
                        icon: SvgPicture.asset(
                          "assets/icons/git.svg",
                          // height: SVConst.kSizeIcons,
                          // width: SVConst.kSizeIcons,
                        ),
                        onPressed: () async {
                          const url =
                              'https://github.com/EliaTolin/StatusVaccini';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        })),
                SizedBox(width: 25),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AutoSizeText(
                        "GitHub",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.red,
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
                                    "Cliccando  questo riquadro trovi il repository contente il codice, puoi sfrutturare la sezione Issue per segnalare problematiche o consigli."),
                          ],
                        ),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: SVConst.textGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
                            color: Colors.blue,
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
                            color: SVConst.textGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 25),
                Container(
                  height: SVConst.kSizeIcons,
                  width: SVConst.kSizeIcons,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/guide.svg",
                    height: SVConst.kSizeIcons,
                    width: SVConst.kSizeIcons,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
