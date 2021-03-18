import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

// ritorna una map contenente tutte le regioni italiane con dati su dosi consegnate e somministrate aggiornate
Future<Map<String, dynamic>> getLatestSummary() async {
  var response = await http.get(URLConst.latestSummaryUrl);
  var regioniLatest = new Map();

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var jsonData = jsonResponse['data'];

    for (dynamic regione in jsonData) {
      regioniLatest[regione['nome_area'].toString()] = {
        'dosiConsegnate': regione['dosi_consegnate'],
        'dosiSomministrate': regione['dosi_somministrate'],
        'percentualeSomministrazione': regione['percentuale_somministrazione'],
        'codiceArea': regione['area']
      };
    }
  }
  return regioniLatest;
}
