import 'dart:convert' as convert;
import 'package:StatusVaccini/constants/url_constant.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: non_constant_identifier_names

// consegne-vaccini-latest:
// dati sul totale delle consegne giornaliere dei vaccini suddivise per regioni.

//CHIAVE: INDEX
class ConsegneVacciniLatest {
  final int index;
  final String area;
  final String fornitore;
  final String data_consegna;
  final int numero_dosi;
  final String nome_area;

  ConsegneVacciniLatest(
      {this.index,
      this.area,
      this.fornitore,
      this.data_consegna,
      this.numero_dosi,
      this.nome_area});

  static Future<List<ConsegneVacciniLatest>> getListData() async {
    var response = await http.get(Uri.parse(URLConst.consegneVacciniLatest));
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

  static List<ConsegneVacciniLatest> getListFromMap(
      Map<String, dynamic> mapData) {
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
