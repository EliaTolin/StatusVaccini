import 'dart:convert' as convert;
import 'package:statusvaccini/constants/url_constant.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: non_constant_identifier_names

// punti-somministrazione-latest:
// punti di somministrazione per ciascuna Regione e Provincia Autonoma.
class PuntiSomministrazioneTipologia {
  final int index;
  final String area;
  final String denominazione_struttura;
  final String tipologia;
  final String nome_regione;

  PuntiSomministrazioneTipologia(
      {this.index,
      this.area,
      this.denominazione_struttura,
      this.tipologia,
      this.nome_regione});

  static Future<List<PuntiSomministrazioneTipologia>> getListData() async {
    var response =
        await http.get(Uri.parse(URLConst.puntiSomministrazioneTipologia));
    List<PuntiSomministrazioneTipologia> list = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];
      for (dynamic element in jsonData) {
        list.add(new PuntiSomministrazioneTipologia(
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

  static Future<List<PuntiSomministrazioneTipologia>> getListFromMap(
      Map<String, dynamic> mapData) async {
    List<PuntiSomministrazioneTipologia> list = [];
    mapData.forEach((key, value) {
      list.add(new PuntiSomministrazioneTipologia(
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
