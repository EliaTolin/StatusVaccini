import 'dart:convert' as convert;
import 'package:StatusVaccini/Models/sommistrazione_vaccini_summary_latest.dart';
import 'package:fl_chart/fl_chart.dart';
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

  static Future<int> getVaccinatiTotale() async {
    var summary;
    int vacctot = 0;

    await SommistrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SommistrazioneVacciniSummaryLatest element in summary) {
      vacctot += element.prima_dose;
      vacctot += element.seconda_dose;
    }

    return vacctot;
  }

  static Future<List<FlSpot>> graphVacciniForDay() async {
    List<FlSpot> data = [];

    var summary;
    await SommistrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    int vacctot = 0;
    for (SommistrazioneVacciniSummaryLatest element in summary) {
      vacctot += element.prima_dose;
      vacctot += element.seconda_dose;
      data.add(FlSpot(element.index.toDouble(), vacctot.toDouble()));
    }
    return data;
  }
}
