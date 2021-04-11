import 'package:flutter/material.dart';
import 'package:statusvaccini/screens/components/cards/consegne_card.dart';
import 'package:statusvaccini/screens/components/cards/somministrazioni_summary_card.dart';
import 'package:statusvaccini/screens/components/cards/variazioni_somministrazioni_card.dart';

class RecapItems {
  Widget card;

  RecapItems({@required this.card});

  static List<RecapItems> get items => [
        RecapItems(
          card: SomministrazioniSummaryCard(
            iconpath: "assets/icons/fast_delivery.svg",
            firstLabel: "Summary",
            secondLabel: "Vaccinazioni",
          ),
        ),
        RecapItems(
          card: VariazioniSommistrazioniCard(
            iconpath: "assets/icons/syringe.svg",
            firstLabel: "Sommistrazioni",
            secondLabel: "Variazioni nei giorni",
          ),
        ),
        RecapItems(
          card: ConsegneCard(
            iconpath: "assets/icons/fast_delivery.svg",
            firstLabel: "Consegne dosi",
            secondLabel: "Variazioni nei giorni",
          ),
        ),
      ];
}
