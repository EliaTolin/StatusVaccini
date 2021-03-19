import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

// NOME FUNZIONE : get[NOME_INFORMAZIONE]();

/*
  SIGLA | REGIONE 
___________________

  ABR	 |	Abruzzo
  BAS	 |	Basilicata
  CAL	 |	Calabria
  CAM	 |	Campania
  EMR	 |	Emilia-Romagna
  FVG	 |	Friuli-Venezia Giulia
  LAZ	 |	Lazio
  LIG	 |  Liguria
  LOM	 |	Lombardia
  MAR	 |	Marche
  MOL	 |	Molise
  PAB	 |  Provincia Autonoma Bolzano / Bozen
  PAT	 |  Provincia Autonoma Trento
  PIE	 | 	Piemonte
  PUG	 |	Puglia
  SAR	 |	Sardegna
  SIC	 |	Sicilia
  TOS	 |	Toscana
  UMB	 |	Umbria
  VDA	 |  Valle d'Aosta / Vallée d'Aoste
  VEN	 |	Veneto
*/

Future<Map<String, dynamic>> getVacciniSummaryLatest() async {
  var response = await http.get(URLConst.vacciniSummaryLatest);
  var regioniLatest = new Map<String, dynamic>();

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var jsonData = jsonResponse['data'];

    for (dynamic regione in jsonData) {
      regioniLatest[regione['area'].toString()] = {
        'index': regione['index'],
        'dosi_consegnate': regione['dosi_consegnate'],
        'dosi_somministrate': regione['dosi_somministrate'],
        'percentuale_somministrazione': regione['percentuale_somministrazione'],
        'nome_area': regione['nome_area']
      };
    }
  }
  return regioniLatest;
}

// Ritorna una map con le ultime consegne dei vaccini
// CHIAVE: INDICE RECORD
Future<Map<String, dynamic>> getConsegneVacciniLatest() async {
  var response = await http.get(URLConst.consegneVacciniLatest);
  var consegneLatest = new Map<String, dynamic>();

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var jsonData = jsonResponse['data'];

    for (dynamic consegna in jsonData) {
      consegneLatest[consegna['index'].toString()] = {
        'area': consegna['area'],
        'fornitore': consegna['fornitore'],
        'data_consegna': consegna['data_consegna'],
        'numero_dosi': consegna['numero_dosi'],
        'nome_area': consegna['nome_area']
      };
    }
  }
  return consegneLatest;
}

// Ritorna una map con le ultime sommistrazioni dei vaccini divise anche per fascia d'età
// CHIAVE: INDICE RECORD
Future<Map<String, dynamic>> getSommistrazioneVacciniLatest() async {
  var response = await http.get(URLConst.somministrazioneVacciniLatest);
  var sommistrazioneLatest = new Map<String, dynamic>();

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var jsonData = jsonResponse['data'];

    for (dynamic sommistrazione in jsonData) {
      sommistrazioneLatest[sommistrazione['index'].toString()] = {
        'area': sommistrazione['area'],
        'fornitore': sommistrazione['fornitore'],
        'data_sommistrazione': sommistrazione['data_sommistrazione'],
        'fascia_anagrafica': sommistrazione['fascia_anagrafica'],
        'sesso_maschile': sommistrazione['sesso_maschile'],
        'sesso_femminile': sommistrazione['sesso_femminile'],
        'categoria_operatori_sanitari_sociosanitari': sommistrazione['categoria_operatori_sanitari_sociosanitari'],
        'categoria_personale_non_sanitario': sommistrazione['categoria_personale_non_sanitario'],
        'categoria_ospiti_rsa': sommistrazione['categoria_ospiti_rsa'],
        'categoria_over80': sommistrazione['categoria_over80'],
        'prima_dose': sommistrazione['prima_dose'],
        'seconda_dose': sommistrazione['seconda_dose'],
        'nome_regione': sommistrazione['nome_regione'],
      };
    }
  }
  return sommistrazioneLatest;
}

// Ritorna una map con le sommistrazioni totali del vaccino.
// CHIAVE: INDICE RECORD
Future<Map<String, dynamic>> getSommistrazioneVacciniSummaryLatest() async {
  var response = await http.get(URLConst.sommistrazioneVacciniSummaryLatest);
  var sommistrazioneSummaryLatest = new Map<String, dynamic>();

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var jsonData = jsonResponse['data'];

    for (dynamic sommistrazione in jsonData) {
      sommistrazioneSummaryLatest[sommistrazione['index'].toString()] = {
        'area': sommistrazione['area'],
        'fornitore': sommistrazione['fornitore'],
        'data_sommistrazione': sommistrazione['data_sommistrazione'],
        'fascia_anagrafica': sommistrazione['fascia_anagrafica'],
        'sesso_maschile': sommistrazione['sesso_maschile'],
        'sesso_femminile': sommistrazione['sesso_femminile'],
        'categoria_operatori_sanitari_sociosanitari': sommistrazione['categoria_operatori_sanitari_sociosanitari'],
        'categoria_personale_non_sanitario': sommistrazione['categoria_personale_non_sanitario'],
        'categoria_ospiti_rsa': sommistrazione['categoria_ospiti_rsa'],
        'categoria_over80': sommistrazione['categoria_over80'],
        'prima_dose': sommistrazione['prima_dose'],
        'seconda_dose': sommistrazione['seconda_dose'],
        'nome_regione': sommistrazione['nome_regione'],
      };
    }
  }
  return sommistrazioneSummaryLatest;
}

// Ritorna una map con le strutture dove si distribuisce il vaccino.
// CHIAVE: INDICE RECORD
Future<Map<String, dynamic>> getPuntiSommistrazioneTipologia() async {
  var response = await http.get(URLConst.puntiSommistrazioneTipologia);
  var puntisommTipologia = new Map<String, dynamic>();

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var jsonData = jsonResponse['data'];

    for (dynamic sommTipo in jsonData) {
      puntisommTipologia[sommTipo['index'].toString()] = {
        'area': sommTipo['area'],
        'denominazione_struttura': sommTipo['denominazione_struttura'],
        'tipologia': sommTipo['tipologia'],
        'nome_regione': sommTipo['nome_regione'],
      };
    }
  }
  return puntisommTipologia;
}

// Ritorna una map con le sommistrazioni totali del vaccino in Italia.
// CHIAVE: INDICE RECORD
Future<Map<String, dynamic>> getAnagraficaVacciniSummaryLatest() async {
  var response = await http.get(URLConst.anagraficaVacciniSummaryLatest);
  var sommistrazioneSummaryLatest = new Map<String, dynamic>();

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var jsonData = jsonResponse['data'];

    for (dynamic sommistrazione in jsonData) {
      sommistrazioneSummaryLatest[sommistrazione['index'].toString()] = {
        'area': sommistrazione['area'],
        'totale': sommistrazione['totale'],
        'data_sommistrazione': sommistrazione['data_sommistrazione'],
        'fascia_anagrafica': sommistrazione['fascia_anagrafica'],
        'sesso_maschile': sommistrazione['sesso_maschile'],
        'sesso_femminile': sommistrazione['sesso_femminile'],
        'categoria_operatori_sanitari_sociosanitari': sommistrazione['categoria_operatori_sanitari_sociosanitari'],
        'categoria_personale_non_sanitario': sommistrazione['categoria_personale_non_sanitario'],
        'categoria_ospiti_rsa': sommistrazione['categoria_ospiti_rsa'],
        'categoria_over80': sommistrazione['categoria_over80'],
        'prima_dose': sommistrazione['prima_dose'],
        'seconda_dose': sommistrazione['seconda_dose'],
      };
    }
  }
  return sommistrazioneSummaryLatest;
}

// Ritorna una stringa contenente l'ultimo aggiornamento dei dati.
Future<String> getLastUpdateDataset() async {
  var response = await http.get(URLConst.lastUpdateDataSet);
  String lastUpdate;

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var jsonData = jsonResponse['data'];
    lastUpdate = jsonData['ultimo_aggiornamento'];
  }
  return lastUpdate;
}
