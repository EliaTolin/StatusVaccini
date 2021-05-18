import 'package:statusvaccini/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:statusvaccini/Screens/components/body_components.dart';
import 'package:statusvaccini/Screens/components/pageitems/recap_items.dart';

class RecapScreen extends StatefulWidget {
  @override
  _RecapScreenState createState() => _RecapScreenState();
}

class _RecapScreenState extends State<RecapScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      appBar: TopBar(size, title: SVConst.titleAppBar),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              for (final recapItems in RecapItems.items) recapItems.card,
              // TO DO
              // FIX HEIGHT BODY.
              // WITHOUT SIZEDBOX THE ELEMENT GOING UNDER BOTTOMBAR AT THE END
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
