import 'dart:convert' as convert;
import 'package:StatusVaccini/Models/sommistrazione_vaccini_summary_latest.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';
import 'package:intl/intl.dart';
import 'package:sortedmap/sortedmap.dart';

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

  //Ritorna una striga formattata con il totali di dosi somministrate
  static Future<String> getSomministrazioniTotali() async {
    final NumberFormat format = NumberFormat.decimalPattern('it');
    var summary;
    int sommTot = 0;

    await SommistrazioneVacciniSummaryLatest.getListData().then((value) => summary = value);

    for (SommistrazioneVacciniSummaryLatest element in summary) {
      sommTot += element.prima_dose;
      sommTot += element.seconda_dose;
    }
    String sommTotString = format.format(sommTot);
    return sommTotString;
  }

  static Future<List<FlSpot>> graphVacciniForDay() async {
    List<FlSpot> data = [];
    var summary;
    await SommistrazioneVacciniSummaryLatest.getListData().then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> somministrazioniPerDay = new SortedMap<String, int>(Ordering.byKey());
    //int sommTot = 0;
    int count = 0;
    for (SommistrazioneVacciniSummaryLatest element in summary) {
      String date = element.data_somministrazione.substring(0, 10);
      //sommTot += (element.prima_dose + element.seconda_dose);
      int tempTot = element.prima_dose + element.seconda_dose;
      if (!somministrazioniPerDay.containsKey(date)) {
        somministrazioniPerDay.putIfAbsent(date, () => tempTot);
      } else {
        somministrazioniPerDay.update(date, (value) => value + tempTot);
      }
    }

    somministrazioniPerDay.forEach((key, value) {
      count += 1;
      data.add(FlSpot(count.toDouble(), value.toDouble()));
    });

    return data;
  }
}
