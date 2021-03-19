import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

// ignore_for_file: non_constant_identifier_names

//@EliaTolin TO DO:
//SALVARE IL CONTENUTO IN CACHE PER EVITARE RALLENTAMENTI.
//CONTROLLO VALIDATA' DATI CON L'ULTIMA DATA DI AGGIORNAMENTO

// Classe delle dosi per regione.
// CHIAVE: SIGLA REGIONE
class VacciniSummaryLatest {
  final String nome_area;
  final String area;
  final int dosi_consegnate;
  final int dosi_somministrate;
  final double percentuale_somministrazione;
  final int index;

  VacciniSummaryLatest(
      {this.nome_area, this.area, this.dosi_consegnate, this.dosi_somministrate, this.percentuale_somministrazione, this.index});

  // Ritorna la lista degli oggetti scaricata dagli OpenData in rete.
  static Future<List<VacciniSummaryLatest>> getListData() async {
    var response = await http.get(URLConst.vacciniSummaryLatest);
    List<VacciniSummaryLatest> list = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];

      for (var element in jsonData) {
        list.add(new VacciniSummaryLatest(
          nome_area: element['nome_area'],
          area: element['area'],
          dosi_consegnate: element['dosi_consegnate'],
          dosi_somministrate: element['dosi_somministrate'],
          percentuale_somministrazione: element['percentuale_somministrazione'],
          index: element['index'],
        ));
      }
    }
    return list;
  }

  static List<VacciniSummaryLatest> getListFromMap(Map<String, dynamic> mapData) {
    List<VacciniSummaryLatest> list = [];
    mapData.forEach((key, value) {
      list.add(new VacciniSummaryLatest(
          nome_area: value['nome_area'],
          area: key,
          dosi_consegnate: value['dosi_consegnate'],
          dosi_somministrate: value['dosi_somministrate'],
          percentuale_somministrazione: value['percentualeSomministrazione'],
          index: value['index']));
    });
    return list;
  }
}

//Classe consegne vaccini per regione e data.
//CHIAVE: INDEX
class ConsegneVacciniLatest {
  final int index;
  final String area;
  final String fornitore;
  final String data_consegna;
  final int numero_dosi;
  final String nome_area;

  ConsegneVacciniLatest({this.index, this.area, this.fornitore, this.data_consegna, this.numero_dosi, this.nome_area});

  static Future<List<ConsegneVacciniLatest>> getListData() async {
    var response = await http.get(URLConst.consegneVacciniLatest);
    List<ConsegneVacciniLatest> list = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];

      for (var element in jsonData) {
        list.add(new ConsegneVacciniLatest(
            index: element['index'],
            area: element['area'],
            fornitore: element['fornitore'],
            data_consegna: element['data_consegna'],
            numero_dosi: element['numero_dosi'],
            nome_area: element['nome_area']));
      }
    }
    return list;
  }

  static List<ConsegneVacciniLatest> getListFromMap(Map<String, dynamic> mapData) {
    List<ConsegneVacciniLatest> list = [];
    mapData.forEach((key, value) {
      list.add(new ConsegneVacciniLatest(
          index: int.parse(key),
          area: value['area'],
          fornitore: value['fornitore'],
          data_consegna: value['data_consegna'],
          numero_dosi: value['numero_dosi'],
          nome_area: value['nome_area']));
    });
    return list;
  }
}
