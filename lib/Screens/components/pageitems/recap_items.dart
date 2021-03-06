import 'package:flutter/material.dart';
import 'package:statusvaccini/Screens/components/cards/record_card.dart';
import 'package:statusvaccini/Screens/components/cards/variazioni_consegne_card.dart';
import 'package:statusvaccini/Screens/components/cards/somministrazioni_summary_card.dart';
import 'package:statusvaccini/Screens/components/cards/variazioni_somministrazioni_card.dart';

class RecapItems {
  Widget card;

  RecapItems({@required this.card});

  static List<RecapItems> get items => [
        RecapItems(
          card: SomministrazioniSummaryCard(
            labelText: "",
            iconpath: "assets/icons/fast_delivery.svg",
            firstLabel: "Summary",
            secondLabel: "Vaccinazioni",
          ),
        ),
        RecapItems(
          card: VariazioniSomministrazioniCard(
            iconpath: "assets/icons/syringe.svg",
            firstLabel: "Somministrazioni",
            secondLabel: "Variazioni nei giorni",
          ),
        ),
        RecapItems(
          card: VariazioniConsegneCard(
            iconpath: "assets/icons/fast_delivery.svg",
            firstLabel: "Consegne dosi",
            secondLabel: "Variazioni nei giorni",
          ),
        ),
        RecapItems(
          card: RecordCard(),
        ),
      ];
}
