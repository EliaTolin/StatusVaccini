import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

// ignore_for_file: non_constant_identifier_names

// somministrazioni-vaccini-summary-latest:
// dati sul totale delle somministrazioni giornaliere per regioni e
// categorie di appartenenza dei soggetti vaccinati.

//CHIAVE: INDEX
class SommistrazioneVacciniSummaryLatest {
  final int index;
  final String area;
  final String data_sommistrazione;
  final int totale;
  final int sesso_maschile;
  final int sesso_femminile;
  final int categoria_operatori_sanitari_sociosanitari;
  final int categoria_personale_non_sanitario;
  final int categoria_ospiti_rsa;
  final int categoria_over80;
  final int prima_dose;
  final int seconda_dose;
  final String nome_regione;

  SommistrazioneVacciniSummaryLatest(
      {this.index,
      this.area,
      this.data_sommistrazione,
      this.totale,
      this.sesso_maschile,
      this.sesso_femminile,
      this.categoria_operatori_sanitari_sociosanitari,
      this.categoria_personale_non_sanitario,
      this.categoria_ospiti_rsa,
      this.categoria_over80,
      this.prima_dose,
      this.seconda_dose,
      this.nome_regione});

  static Future<List<SommistrazioneVacciniSummaryLatest>> getListData() async {
    var response = await http.get(URLConst.somministrazioneVacciniLatest);
    List<SommistrazioneVacciniSummaryLatest> list = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];

      for (var element in jsonData) {
        list.add(new SommistrazioneVacciniSummaryLatest(
          index: element['index'],
          area: element['area'],
          data_sommistrazione: element['data_sommistrazione'],
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
          nome_regione: element['nome_regione'],
        ));
      }
    }
    return list;
  }

  static List<SommistrazioneVacciniSummaryLatest> getListFromMap(
      Map<String, dynamic> mapData) {
    List<SommistrazioneVacciniSummaryLatest> list = [];
    mapData.forEach((key, value) {
      list.add(new SommistrazioneVacciniSummaryLatest(
        index: value['index'],
        area: value['area'],
        data_sommistrazione: value['data_sommistrazione'],
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
        nome_regione: value['nome_regione'],
      ));
    });
    return list;
  }
}
