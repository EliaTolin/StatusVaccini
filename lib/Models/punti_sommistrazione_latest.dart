import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

// ignore_for_file: non_constant_identifier_names

// punti-somministrazione-latest:
// punti di somministrazione per ciascuna Regione e Provincia Autonoma.
class PuntiSommistrazioneTipologia {
  final int index;
  final String area;
  final String denominazione_struttura;
  final String tipologia;
  final String nome_regione;

  PuntiSommistrazioneTipologia(
      {this.index,
      this.area,
      this.denominazione_struttura,
      this.tipologia,
      this.nome_regione});

  static Future<List<PuntiSommistrazioneTipologia>> getListData() async {
    var response = await http.get(Uri.parse(URLConst.puntiSommistrazioneTipologia));
    List<PuntiSommistrazioneTipologia> list = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];
      for (dynamic element in jsonData) {
        list.add(new PuntiSommistrazioneTipologia(
          index: element['index'],
          area: element['area'],
          denominazione_struttura: element['denominazione_struttura'],
          tipologia: element['tipologia'],
          nome_regione: element['nome_regione'],
        ));
      }
    }
    return list;
  }

  static Future<List<PuntiSommistrazioneTipologia>> getListFromMap(
      Map<String, dynamic> mapData) async {
    List<PuntiSommistrazioneTipologia> list = [];
    mapData.forEach((key, value) {
      list.add(new PuntiSommistrazioneTipologia(
        index: value['index'],
        area: value['area'],
        denominazione_struttura: value['denominazione_struttura'],
        tipologia: value['tipologia'],
        nome_regione: value['nome_regione'],
      ));
    });
    return list;
  }
}
