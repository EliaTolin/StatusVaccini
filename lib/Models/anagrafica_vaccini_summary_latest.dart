import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

// ignore_for_file: non_constant_identifier_names

class AnagraficaVacciniSummaryLatest {
  final String fascia_anagrafica;
  final int totale;
  final int sesso_maschile;
  final int sesso_femminile;
  final int categoria_operatori_sanitari_sociosanitari;
  final int categoria_personale_non_sanitario;
  final int categoria_ospiti_rsa;
  final int categoria_over80;
  final int prima_dose;
  final int seconda_dose;

  AnagraficaVacciniSummaryLatest(
      {this.fascia_anagrafica,
      this.totale,
      this.sesso_maschile,
      this.sesso_femminile,
      this.categoria_operatori_sanitari_sociosanitari,
      this.categoria_personale_non_sanitario,
      this.categoria_ospiti_rsa,
      this.categoria_over80,
      this.prima_dose,
      this.seconda_dose});

  Future<List<AnagraficaVacciniSummaryLatest>> getListData() async {
    var response = await http.get(URLConst.anagraficaVacciniSummaryLatest);
    List<AnagraficaVacciniSummaryLatest> list = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];
      for (dynamic element in jsonData) {
        list.add(new AnagraficaVacciniSummaryLatest(
          fascia_anagrafica: element['fascia_anagrafica'],
          totale: element['totale'],
          sesso_maschile: element['sesso_maschile'],
          sesso_femminile: element['sesso_femminile'],
          categoria_operatori_sanitari_sociosanitari:
              element['categoria_operatori_sanitari_sociosanitari'],
          categoria_personale_non_sanitario:
              element['categoria_personale_non_sanitario'],
          categoria_ospiti_rsa: element['categoria_ospiti_rsa'],
          categoria_over80: element['categoria_over80'],
          prima_dose: element['prima_dose'],
          seconda_dose: element['seconda_dose'],
        ));
      }
    }
    return list;
  }

  static List<AnagraficaVacciniSummaryLatest> getListFromMap(
      Map<String, dynamic> mapData) {
    List<AnagraficaVacciniSummaryLatest> list = [];
    mapData.forEach((key, value) {
      list.add(new AnagraficaVacciniSummaryLatest(
        fascia_anagrafica: value['fascia_anagrafica'],
        totale: value['totale'],
        sesso_maschile: value['sesso_maschile'],
        sesso_femminile: value['sesso_femminile'],
        categoria_operatori_sanitari_sociosanitari:
            value['categoria_operatori_sanitari_sociosanitari'],
        categoria_personale_non_sanitario:
            value['categoria_personale_non_sanitario'],
        categoria_ospiti_rsa: value['categoria_ospiti_rsa'],
        categoria_over80: value['categoria_over80'],
        prima_dose: value['prima_dose'],
        seconda_dose: value['seconda_dose'],
      ));
    });
    return list;
  }
}
