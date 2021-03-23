import 'package:flutter/material.dart';

//USE THIS CLASS FOR ONLY CONSTANT.

abstract class SVConst {
  //TITLE APPBAR
  static const String titleAppBar = "Status Vaccini";

  //VIEW ROUTE
  static const String MainRoute = '/';
  static const String InfoViewRoute = '/info';
  static const String HomeViewRoute = '/home';
  static const String RecapViewRoute = '/recap';
  //COLOR CONSTANT
  static const mainColor = Colors.cyan;
  static const textColor = Colors.white;
  static Color backColor = Colors.grey.shade200;
  static const iconColor = mainColor;
  static const cardColor = Colors.white;

  static const List<Color> pieColors = [
    Color.fromARGB(255, 172, 25, 100),
    Color.fromRGBO(255, 172, 25, 100),
    Color.fromRGBO(13, 255, 118, 100),
    Color.fromRGBO(255, 43, 25, 100),
    Color.fromRGBO(13, 128, 255, 100),
    Color.fromARGB(100, 255, 172, 25),
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.grey,
    Colors.cyan,
  ];

  static const List<Color> linearColors = [
    Colors.cyan,
    Color.fromARGB(255, 172, 25, 100),
    Color.fromRGBO(255, 172, 25, 100),
    Color.fromRGBO(13, 255, 118, 100),
    Color.fromRGBO(255, 43, 25, 100),
    Color.fromRGBO(13, 128, 255, 100),
    Color.fromARGB(100, 255, 172, 25),
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.grey,
  ];

  //RADIUS ELEMENT
  static const double radiusComponent = 40;

  //SIZE ELEMENT
  static const double kHeighBarRatio = 0.15;
  static const double kSizeIcons = 50;
}

abstract class URLConst {
  //GITHUB OPEN DATA
  //https://github.com/italia/covid19-opendata-vaccini/tree/master/dati

  //anagrafica-vaccini-summary-latest: totali delle somministrazioni per fasce d'età.
  static final String anagraficaVacciniSummaryLatest =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/anagrafica-vaccini-summary-latest.json';

  //consegne-vaccini-latest: dati sul totale delle consegne giornaliere dei vaccini suddivise per regioni.
  static final String consegneVacciniLatest =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/consegne-vaccini-latest.json';

  //punti-somministrazione-latest: punti di somministrazione per ciascuna Regione e Provincia Autonoma.
  static final String puntiSommistrazioneLatest =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/punti-somministrazione-latest.json';
  static final String puntiSommistrazioneTipologia =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/punti-somministrazione-tipologia.json';

  //somministrazioni-vaccini-latest: dati sulle somministrazioni giornaliere dei vaccini suddivisi per regioni,
  //fasce d'età e categorie di appartenenza dei soggetti vaccinati.
  static final String somministrazioneVacciniLatest =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/somministrazioni-vaccini-latest.json';

  //somministrazioni-vaccini-summary-latest: dati sul totale delle somministrazioni giornaliere per regioni
  //e categorie di appartenenza dei soggetti vaccinati.
  static final String sommistrazioneVacciniSummaryLatest =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/somministrazioni-vaccini-summary-latest.json';
  //vaccini-summary-latest: dati sul totale delle consegne e somministrazioni avvenute sino ad oggi, includendo la percentuale di
  //dosi somministrate (sul totale delle dosi consegnate) suddivise per regioni.
  static final String vacciniSummaryLatest =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/vaccini-summary-latest.json';

  //last-update-dataset: data e ora di ultimo aggiornamento del dataset.
  static final String lastUpdateDataSet =
      'https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/last-update-dataset.json';
}
