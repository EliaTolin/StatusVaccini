import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

//RITORNA L'ULTIMO AGGIORNAMENTO DELLE INFORMAZIONI.
abstract class OpenData {
  Future<String> getLastUpdateData() async {
    var response = await http.get(Uri.parse(URLConst.lastUpdateDataSet));
    String lastUpdate;

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];
      lastUpdate = jsonData['ultimo_aggiornamento'];
    }
    return lastUpdate;
  }
}
