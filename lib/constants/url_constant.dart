class URLConst {
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
