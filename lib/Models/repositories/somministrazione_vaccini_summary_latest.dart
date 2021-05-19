import 'dart:convert' as convert;
import 'package:statusvaccini/constants/url_constant.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: non_constant_identifier_names

// somministrazioni-vaccini-summary-latest:
// dati sul totale delle somministrazioni giornaliere per regioni e
// categorie di appartenenza dei soggetti vaccinati.

//CHIAVE: INDEX
class SomministrazioneVacciniSummaryLatest {
  final int index;
  final String area;
  final String data_somministrazione;
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

  SomministrazioneVacciniSummaryLatest({
    this.index,
    this.area,
    this.data_somministrazione,
    this.totale,
    this.sesso_maschile,
    this.sesso_femminile,
    this.categoria_operatori_sanitari_sociosanitari,
    this.categoria_personale_non_sanitario,
    this.categoria_ospiti_rsa,
    this.categoria_over80,
    this.prima_dose,
    this.seconda_dose,
    this.nome_regione,
  });

  static Future<List<SomministrazioneVacciniSummaryLatest>>
      getListData() async {
    var response = await http
        .get(Uri.parse(URLConst.somministrazioneVacciniSummaryLatest));
    List<SomministrazioneVacciniSummaryLatest> list = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];

      for (var element in jsonData) {
        list.add(new SomministrazioneVacciniSummaryLatest(
          index: element['index'],
          area: element['area'],
          data_somministrazione: element['data_somministrazione'],
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
          nome_regione: element['nome_area'],
        ));
      }
    }
    return list;
  }

  static List<SomministrazioneVacciniSummaryLatest> getListFromMap(
      Map<String, dynamic> mapData) {
    List<SomministrazioneVacciniSummaryLatest> list = [];
    mapData.forEach((key, value) {
      list.add(new SomministrazioneVacciniSummaryLatest(
        index: value['index'],
        area: value['area'],
        data_somministrazione: value['data_somministrazione'],
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
