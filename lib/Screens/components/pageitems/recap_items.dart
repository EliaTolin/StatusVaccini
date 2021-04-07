import 'package:flutter/material.dart';
import 'package:statusvaccini/screens/components/cards/sommistrazioni_card.dart';

class RecapItems {
  Widget card;

  RecapItems({@required this.card});

  static List<RecapItems> get items => [
        RecapItems(
          card: SommistrazioniCard(
            iconpath: "assets/icons/order.svg",
            firstLabel: "Sommistrazioni",
            secondLabel: "Variazioni nei giorni",
          ),
        ),
      ];
}
