import 'dart:convert' as convert;
import 'package:StatusVaccini/Models/consegne_vaccini_latest.dart';
import 'package:StatusVaccini/Models/sommistrazione_vaccini_summary_latest.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:StatusVaccini/constant.dart';
import 'package:sortedmap/sortedmap.dart';

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

  static Future<int> getSommistrazioniOggi() async {
    var summary;
    int vaccTot = 0;
    DateTime now = DateTime.now();
    String todayDate = "";

    todayDate += now.year.toString() + "-";
    if (now.month < 10)
      todayDate += ("0" + now.month.toString());
    else
      todayDate += now.month.toString();
    todayDate += ("-" + now.day.toString());

    await SommistrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SommistrazioneVacciniSummaryLatest element in summary) {
      String date = element.data_somministrazione.substring(0, 10);
      if (date == todayDate) {
        vaccTot += element.prima_dose;
        vaccTot += element.seconda_dose;
      }
    }
    return vaccTot;
  }

  //Ritorna una striga formattata con il totali di dosi somministrate
  static Future<int> getSomministrazioniTotali() async {
    var summary;
    int sommTot = 0;

    await SommistrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SommistrazioneVacciniSummaryLatest element in summary) {
      sommTot += element.prima_dose;
      sommTot += element.seconda_dose;
    }
    return sommTot;
  }

  static Future<List<FlSpot>> graphVacciniTotal() async {
    List<FlSpot> data = [];
    var summary;
    int vaccini = 0;

    await SommistrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SommistrazioneVacciniSummaryLatest element in summary) {
      vaccini += element.prima_dose;
      vaccini += element.seconda_dose;
      data.add(FlSpot(element.index.toDouble(), vaccini.toDouble()));
    }

    return data;
  }

  static Future<List<FlSpot>> graphVacciniForDay() async {
    List<FlSpot> data = [];
    var summary;
    await SommistrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> somministrazioniPerDay =
        new SortedMap<String, int>(Ordering.byKey());

    for (SommistrazioneVacciniSummaryLatest element in summary) {
      String date = element.data_somministrazione.substring(0, 10);
      int tempTot = element.prima_dose + element.seconda_dose;

      if (!somministrazioniPerDay.containsKey(date)) {
        somministrazioniPerDay.putIfAbsent(date, () => tempTot);
      } else {
        somministrazioniPerDay.update(date, (value) => value + tempTot);
      }
    }

    somministrazioniPerDay.forEach((key, value) {
      data.add(FlSpot(DateTime.parse(key).millisecondsSinceEpoch.toDouble(),
          value.toDouble()));
    });

    return data;
  }

  //RITORNA IL NUMERO DELLA CONSEGNE DI DOSI PER GIORNO
  static Future<List<FlSpot>> graphDeliveryForDay() async {
    List<FlSpot> data = [];
    var summary;
    await ConsegneVacciniLatest.getListData().then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> deliveryForDay =
        new SortedMap<String, int>(Ordering.byKey());

    for (ConsegneVacciniLatest element in summary) {
      String date = element.data_consegna.substring(0, 10);
      int tempTot = element.numero_dosi;

      if (!deliveryForDay.containsKey(date)) {
        deliveryForDay.putIfAbsent(date, () => tempTot);
      } else {
        deliveryForDay.update(date, (value) => value + tempTot);
      }
    }

    deliveryForDay.forEach((key, value) {
      data.add(FlSpot(DateTime.parse(key).millisecondsSinceEpoch.toDouble(),
          value.toDouble()));
    });

    return data;
  }

  static Future<List<FlSpot>> graphDeliveryTotal() async {
    List<FlSpot> data = [];
    var summary;
    int dosiConsegnate = 0;

    await ConsegneVacciniLatest.getListData().then((value) => summary = value);

    for (ConsegneVacciniLatest element in summary) {
      dosiConsegnate += element.numero_dosi;
      data.add(FlSpot(element.index.toDouble(), dosiConsegnate.toDouble()));
    }

    return data;
  }

  //RITORNA IL NUMERO TOTALE DELLE DOSI CONSEGNATE
  static Future<int> getDosiTotali() async {
    var summary;
    int sommTot = 0;

    await ConsegneVacciniLatest.getListData().then((value) => summary = value);

    for (ConsegneVacciniLatest element in summary) {
      sommTot += element.numero_dosi;
    }

    return sommTot;
  }

  static Future<List<Fornitore>> getDosiPerFornitore() async {
    var data;
    List<Fornitore> fornitori = [];
    await ConsegneVacciniLatest.getListData().then((value) => data = value);
    for (ConsegneVacciniLatest element in data) {
      var exist = fornitori.where((f) => (f.nome == element.fornitore));
      if (exist.isEmpty) {
        fornitori.add(Fornitore(
            nome: element.fornitore, numeroDosi: element.numero_dosi));
      } else {
        fornitori.forEach((f) {
          if (f.nome == element.fornitore) {
            f.numeroDosi += element.numero_dosi;
          }
        });
      }
    }

    int numeroTotaleDosi;
    await getDosiTotali().then((value) => numeroTotaleDosi = value);

    fornitori.forEach((element) {
      element.percentualeSuTot = (element.numeroDosi * 100) / numeroTotaleDosi;
      element.percentualeSuTot =
          double.parse(element.percentualeSuTot.toStringAsFixed(2));
    });

    return fornitori;
  }

  static Future<int> getDosiConsegnateOggi() async {
    var summary;
    int dosiTot = 0;
    DateTime now = DateTime.now();
    String todayDate = "";

    todayDate += now.year.toString() + "-";
    if (now.month < 10)
      todayDate += ("0" + now.month.toString());
    else
      todayDate += now.month.toString();
    todayDate += ("-" + now.day.toString());

    await ConsegneVacciniLatest.getListData().then((value) => summary = value);

    for (ConsegneVacciniLatest element in summary) {
      String date = element.data_consegna.substring(0, 10);
      if (date == todayDate) {
        dosiTot += element.numero_dosi;
      }
    }
    return dosiTot;
  }
}

class Fornitore {
  String nome;
  int numeroDosi;
  double percentualeSuTot;

  Fornitore({this.nome, this.numeroDosi, this.percentualeSuTot});
}
