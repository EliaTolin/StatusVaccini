import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';

// ignore_for_file: non_constant_identifier_names

// somministrazioni-vaccini-latest:
// dati sulle somministrazioni giornaliere dei vaccini suddivisi per regioni,
// fasce d'età e categorie di appartenenza dei soggetti vaccinati.

//CHIAVE: INDEX
class SommistrazioneVacciniLatest {
  final int index;
  final String area;
  final String fornitore;
  final String data_sommistrazione;
  final String fascia_anagrafica;
  final int sesso_maschile;
  final int sesso_femminile;
  final int categoria_operatori_sanitari_sociosanitari;
  final int categoria_personale_non_sanitario;
  final int categoria_ospiti_rsa;
  final int categoria_over80;
  final int prima_dose;
  final int seconda_dose;
  final String nome_regione;

  SommistrazioneVacciniLatest(
      {this.index,
      this.area,
      this.fornitore,
      this.data_sommistrazione,
      this.fascia_anagrafica,
      this.sesso_maschile,
      this.sesso_femminile,
      this.categoria_operatori_sanitari_sociosanitari,
      this.categoria_personale_non_sanitario,
      this.categoria_ospiti_rsa,
      this.categoria_over80,
      this.prima_dose,
      this.seconda_dose,
      this.nome_regione});

  static Future<List<SommistrazioneVacciniLatest>> getListData() async {
    var response = await http.get(URLConst.somministrazioneVacciniLatest);
    List<SommistrazioneVacciniLatest> list = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonData = jsonResponse['data'];

      for (var element in jsonData) {
        list.add(new SommistrazioneVacciniLatest(
          index: element['index'],
          area: element['area'],
          fornitore: element['fornitore'],
          data_sommistrazione: element['data_sommistrazione'],
          fascia_anagrafica: element['fascia_anagrafica'],
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

  static List<SommistrazioneVacciniLatest> getListFromMap(
      Map<String, dynamic> mapData) {
    List<SommistrazioneVacciniLatest> list = [];
    mapData.forEach((key, value) {
      list.add(new SommistrazioneVacciniLatest(
        index: value['index'],
        area: value['area'],
        fornitore: value['fornitore'],
        data_sommistrazione: value['data_sommistrazione'],
        fascia_anagrafica: value['fascia_anagrafica'],
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
