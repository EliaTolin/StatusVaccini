import 'package:statusvaccini/models/opendata.dart';
import 'package:statusvaccini/screens/components/graphs/graph_bar_card.dart';
import 'package:statusvaccini/screens/components/graphs/graph_linear_card.dart';
import 'package:statusvaccini/screens/components/graphs/graph_multiple_linear_card.dart';
import 'package:statusvaccini/screens/components/cards/regioni_card_view.dart';
import 'package:statusvaccini/screens/components/graphs/graph_linear_ultime_consegne.dart';
import 'package:statusvaccini/screens/components/graphs/graph_linear_ultime_sommistrazioni.dart';
import 'package:flutter/material.dart';

import '../graphs/graph_pie_card.dart';

class RecapItems {
  Widget card;

  RecapItems({@required this.card});

  static List<RecapItems> get items => [
        RecapItems(
          card: Text("Elia"),
        ),
      ];
}
