import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

// ignore_for_file: non_constant_identifier_names

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
      {this.nome_area,
      this.area,
      this.dosi_consegnate,
      this.dosi_somministrate,
      this.percentuale_somministrazione,
      this.index});

  //@EliaTolin TO DO:
  //SALVARE IL CONTENUTO IN CACHE PER EVITARE RALLENTAMENTI.
  //CONTROLLO VALIDATA' DATI CON L'ULTIMA DATA DI AGGIORNAMENTO

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

  //DEPRECATED METHOD 
  static List<VacciniSummaryLatest> getList(Map<String, dynamic> jsonData) {
    List<VacciniSummaryLatest> list = [];
    jsonData.forEach((key, value) {
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
