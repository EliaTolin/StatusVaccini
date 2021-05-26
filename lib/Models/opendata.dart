import 'dart:convert' as convert;
import 'package:statusvaccini/constants/url_constant.dart';
import 'package:statusvaccini/Models/repositories/consegne_vaccini_latest.dart';
import 'package:statusvaccini/Models/repositories/somministrazione_vaccini_summary_latest.dart';
import 'package:statusvaccini/Models/repositories/somministrazione_vaccini_latest.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:sortedmap/sortedmap.dart';
import 'package:intl/intl.dart';

abstract class OpenData {
  //RITORNA L'ULTIMO AGGIORNAMENTO DELLE INFORMAZIONI
  static Future<DateTime> getLastUpdateData() async {
    var response = await http.get(Uri.parse(URLConst.lastUpdateDataSet));
    String lastUpdate;

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      lastUpdate = jsonResponse['ultimo_aggiornamento'];
    }
    var date = DateTime.parse(lastUpdate);
    return date;
  }

  //RITORNA IL NUMERO DELLE SOMMISTRAZIONI EFFETTUATE OGGI
  static Future<UltimeSomministrazioni> getUltimeSomministrazioni() async {
    var summary;
    UltimeSomministrazioni ultimeSomministrazioni =
        new UltimeSomministrazioni();
    ultimeSomministrazioni.data = new DateTime(1979, 01, 01);

    //GET INFORMATION
    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      var dataTemp = element.data_somministrazione.substring(0, 10);

      List<String> splitDate = dataTemp.split("-");

      DateTime dataSomministrazione = new DateTime(int.parse(splitDate[0]),
          int.parse(splitDate[1]), int.parse(splitDate[2]));

      if (ultimeSomministrazioni.data.isBefore(dataSomministrazione)) {
        if (element.prima_dose != 0 || element.seconda_dose != 0)
          ultimeSomministrazioni = new UltimeSomministrazioni(
              data: dataSomministrazione,
              primaDose: element.prima_dose,
              secondaDose: element.seconda_dose,
              dosiTotali: (element.prima_dose + element.seconda_dose));
      } else if (ultimeSomministrazioni.data
          .isAtSameMomentAs(dataSomministrazione)) {
        ultimeSomministrazioni.dosiTotali +=
            (element.prima_dose + element.seconda_dose);
        ultimeSomministrazioni.primaDose += element.prima_dose;
        ultimeSomministrazioni.secondaDose += element.seconda_dose;
      }
    }
    return ultimeSomministrazioni;
  }

  //RITORNA IL NUMERO DELLE SOMMISTRAZIONI TOTALI
  static Future<int> getSomministrazioniTotali() async {
    var summary;
    int sommTot = 0;

    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      sommTot += element.prima_dose;
      sommTot += element.seconda_dose;
    }
    return sommTot;
  }

  //RITORNA IL GRAFICO DELLA SOMMISTRAZIONI TOTALI
  static Future<List<FlSpot>> graphSomministrazioniTotali() async {
    List<FlSpot> data = [];
    var summary;
    int vaccini = 0;

    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      vaccini += element.prima_dose;
      vaccini += element.seconda_dose;
      data.add(FlSpot(element.index.toDouble(), vaccini.toDouble()));
    }

    return data;
  }

  //RITORNA UNA MAPPA CONTENENTE LE DOSI SOMMISTRATE PER GIORNO
  static Future<Map<String, int>> getSomministrazioniPerGiorno() async {
    var summary;
    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> somministrazioniPerGiorno =
        new SortedMap<String, int>(Ordering.byKey());

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      String date = element.data_somministrazione.substring(0, 10);
      int tempTot = element.prima_dose + element.seconda_dose;

      if (!somministrazioniPerGiorno.containsKey(date)) {
        somministrazioniPerGiorno.putIfAbsent(date, () => tempTot);
      } else {
        somministrazioniPerGiorno.update(date, (value) => value + tempTot);
      }
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    if (!somministrazioniPerGiorno.containsKey(formattedDate)) {
      somministrazioniPerGiorno.putIfAbsent(formattedDate, () => 0);
    }

    somministrazioniPerGiorno = _addZeroDays(somministrazioniPerGiorno);

    return somministrazioniPerGiorno;
  }

  //RITORNA LA MAPPA CONTENTE IL GIORNO CON LE SOMMINISTRAZIONI MAGGIORI
  static Future<Map<String, int>> getRecordSomministrazioni() async {
    Map<String, int> recordSomministrazioni = new Map<String, int>();
    Map<String, int> somministrazioniPerGiorno;
    await getSomministrazioniPerGiorno()
        .then((value) => somministrazioniPerGiorno = value);

    somministrazioniPerGiorno.forEach((key, value) {
      if (recordSomministrazioni.isEmpty ||
          value >= recordSomministrazioni.values.toList()[0]) {
        recordSomministrazioni.clear();
        recordSomministrazioni[key] = value;
      }
    });
    return recordSomministrazioni;
  }

  //RITORNA LA MAPPA CONTENTE IL GIORNO CON LE CONSEGNE MAGGIORI
  static Future<Map<String, int>> getRecordConsegne() async {
    Map<String, int> recordConsegne = new Map<String, int>();
    Map<String, int> consegnePerGiorno;
    await getConsegnePerGiorno().then((value) => consegnePerGiorno = value);

    consegnePerGiorno.forEach((key, value) {
      if (recordConsegne.isEmpty ||
          value >= recordConsegne.values.toList()[0]) {
        recordConsegne.clear();
        recordConsegne[key] = value;
      }
    });
    return recordConsegne;
  }

  //RITORNA UNA MAPPA CONTENENTE DELLE DOSI CONSEGNATE PER GIORNO
  static Future<Map<String, int>> getConsegnePerGiorno() async {
    var summary;
    await ConsegneVacciniLatest.getListData().then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> consegnePerGiorno =
        new SortedMap<String, int>(Ordering.byKey());

    for (ConsegneVacciniLatest element in summary) {
      String date = element.data_consegna.substring(0, 10);
      int tempTot = element.numero_dosi;

      if (!consegnePerGiorno.containsKey(date)) {
        consegnePerGiorno.putIfAbsent(date, () => tempTot);
      } else {
        consegnePerGiorno.update(date, (value) => value + tempTot);
      }
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    if (!consegnePerGiorno.containsKey(formattedDate)) {
      consegnePerGiorno.putIfAbsent(formattedDate, () => 0);
    }

    consegnePerGiorno = _addZeroDays(consegnePerGiorno);

    return consegnePerGiorno;
  }

  //RITORNA IL GRAFICO DELLA DOSI SOMMISTRATE PER GIORNO
  static Future<List<FlSpot>> graphSomministrazioniPerGiorno() async {
    List<FlSpot> data = [];
    var summary;
    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> somministrazioniPerGiorno =
        new SortedMap<String, int>(Ordering.byKey());

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      String date = element.data_somministrazione.substring(0, 10);
      int tempTot = element.prima_dose + element.seconda_dose;

      if (!somministrazioniPerGiorno.containsKey(date)) {
        somministrazioniPerGiorno.putIfAbsent(date, () => tempTot);
      } else {
        somministrazioniPerGiorno.update(date, (value) => value + tempTot);
      }
    }

    somministrazioniPerGiorno = _addZeroDays(somministrazioniPerGiorno);

    somministrazioniPerGiorno.forEach((key, value) {
      data.add(FlSpot(DateTime.parse(key).millisecondsSinceEpoch.toDouble(),
          value.toDouble()));
    });

    return data;
  }

  //RITORNA IL NUMERO DELLA CONSEGNE DI DOSI PER GIORNO
  static Future<List<FlSpot>> graphConsegnePerGiorno() async {
    List<FlSpot> data = [];
    var summary;
    await ConsegneVacciniLatest.getListData().then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> consegnePerGiorno =
        new SortedMap<String, int>(Ordering.byKey());

    for (ConsegneVacciniLatest element in summary) {
      String date = element.data_consegna.substring(0, 10);
      int tempTot = element.numero_dosi;

      if (!consegnePerGiorno.containsKey(date)) {
        consegnePerGiorno.putIfAbsent(date, () => tempTot);
      } else {
        consegnePerGiorno.update(date, (value) => value + tempTot);
      }
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    if (!consegnePerGiorno.containsKey(formattedDate)) {
      consegnePerGiorno.putIfAbsent(formattedDate, () => 0);
    }

    consegnePerGiorno = _addZeroDays(consegnePerGiorno);

    consegnePerGiorno.forEach((key, value) {
      data.add(FlSpot(DateTime.parse(key).millisecondsSinceEpoch.toDouble(),
          value.toDouble()));
    });

    return data;
  }

  //RITORNA IL GRAFICO DELLA CONSEGNE TOTALI
  static Future<List<FlSpot>> graphConsegneTotali() async {
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

  //RITORNA IL NUMERO TOTALE DELLE PRIME DOSI
  static Future<int> getTotalePrimeDosi() async {
    var summary;
    int somministrazioni = 0;

    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      somministrazioni += element.prima_dose;
    }

    return somministrazioni;
  }

  //RITORNA IL NUMERO TOTALE DELLE SECONDI DOSI
  static Future<int> getTotaleSecondiDosi() async {
    var summary;
    int somministrazioni = 0;

    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      somministrazioni += element.seconda_dose;
    }

    return somministrazioni;
  }

  //RITORNA IL NUMERO DELLE DOSI PER FORNITORE
  static Future<List<Fornitore>> getDosiPerFornitore() async {
    var data;
    List<Fornitore> fornitori = [];
    await ConsegneVacciniLatest.getListData().then((value) => data = value);
    for (ConsegneVacciniLatest element in data) {
      var exist = fornitori.where((f) => (f.nome == element.fornitore));
      if (exist.isEmpty) {
        fornitori
            .add(Fornitore(element.fornitore, numeroDosi: element.numero_dosi));
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

  //RITORNA IL NUMERO DELLA DOSI CONSEGNATE OGGI
  static Future<UltimaConsegna> getUltimeDosiConsegnate() async {
    var summary;

    UltimaConsegna ultimaConsegna = new UltimaConsegna();

    ultimaConsegna.data = new DateTime(1979, 01, 01);

    await ConsegneVacciniLatest.getListData().then((value) => summary = value);

    for (ConsegneVacciniLatest element in summary) {
      var dataTemp = element.data_consegna.substring(0, 10);
      List<String> splitDate = dataTemp.split("-");
      DateTime dataConsegna = new DateTime(int.parse(splitDate[0]),
          int.parse(splitDate[1]), int.parse(splitDate[2]));
      if (ultimaConsegna.data.isBefore(dataConsegna)) {
        ultimaConsegna = new UltimaConsegna(data: dataConsegna);
      }
    }

    for (ConsegneVacciniLatest element in summary) {
      var dataTemp = element.data_consegna.substring(0, 10);
      List<String> splitDate = dataTemp.split("-");
      DateTime dataConsegna = new DateTime(
        int.parse(splitDate[0]),
        int.parse(splitDate[1]),
        int.parse(splitDate[2]),
      );

      if (dataConsegna.day == ultimaConsegna.data.day &&
          dataConsegna.month == ultimaConsegna.data.month &&
          dataConsegna.year == ultimaConsegna.data.year) {
        if (ultimaConsegna.fornitori == null) {
          ultimaConsegna.fornitori = [];
          ultimaConsegna.fornitori.add(new Fornitore(element.fornitore,
              numeroDosi: element.numero_dosi));
        } else {
          int i = 0;
          bool exist = false;

          for (Fornitore f in ultimaConsegna.fornitori) {
            if (f.nome == element.fornitore) {
              exist = true;
              ultimaConsegna.fornitori[i].numeroDosi += element.numero_dosi;
            }
            i++;
          }

          if (!exist)
            ultimaConsegna.fornitori.add(new Fornitore(element.fornitore,
                numeroDosi: element.numero_dosi));
        }
      }
    }

    return ultimaConsegna;
  }

  //RITORNA IL GRAFICO DELLE PRIME DOSI PER GIORNO
  static Future<List<FlSpot>> graphPrimeDosi() async {
    List<FlSpot> data = [];
    var summary;
    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> consegnePerGiorno =
        new SortedMap<String, int>(Ordering.byKey());

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      String date = element.data_somministrazione.substring(0, 10);

      int dosiTemp = element.prima_dose;
      if (!consegnePerGiorno.containsKey(date)) {
        consegnePerGiorno.putIfAbsent(date, () => dosiTemp);
      } else {
        consegnePerGiorno.update(date, (value) => value + dosiTemp);
      }
    }

    consegnePerGiorno.forEach((key, value) {
      data.add(FlSpot(DateTime.parse(key).millisecondsSinceEpoch.toDouble(),
          value.toDouble()));
    });

    return data;
  }

  //RITORNA IL GRAFICO DELLE SECONDE DOSI PER GIORNO
  static Future<List<FlSpot>> graphSecondeDosi() async {
    List<FlSpot> data = [];
    var summary;
    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> consegnePerGiorno =
        new SortedMap<String, int>(Ordering.byKey());

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      String date = element.data_somministrazione.substring(0, 10);

      int dosiTemp = element.seconda_dose;
      if (!consegnePerGiorno.containsKey(date)) {
        consegnePerGiorno.putIfAbsent(date, () => dosiTemp);
      } else {
        consegnePerGiorno.update(date, (value) => value + dosiTemp);
      }
    }

    consegnePerGiorno.forEach((key, value) {
      data.add(FlSpot(DateTime.parse(key).millisecondsSinceEpoch.toDouble(),
          value.toDouble()));
    });

    return data;
  }

  //RITORNA UNA MAPPA CON LE SOMMISTRAZIONI PER FASCE D'ETA'
  static Future<Map<String, int>> getInfoSomministrazioniFasceEta() async {
    var summary;
    await SomministrazioneVacciniLatest.getListData()
        .then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> fasceEtaInfo =
        new SortedMap<String, int>(Ordering.byKey());

    for (SomministrazioneVacciniLatest element in summary) {
      String eta = element.fascia_anagrafica;

      int dosiTemp = 0;

      dosiTemp += (element.prima_dose + element.seconda_dose);

      if (!fasceEtaInfo.containsKey(eta)) {
        fasceEtaInfo.putIfAbsent(eta, () => dosiTemp);
      } else {
        fasceEtaInfo.update(eta, (value) => value + dosiTemp);
      }
    }
    return fasceEtaInfo;
  }

  //RITORNA UNA MAPPA CONTENTE IL NUMERO DI PRIME SOMMISTRAZIONI PER REGIONE
  static Future<Map<String, int>> getPrimaSomministrazionePerRegione() async {
    var summary;

    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> somministrazioniRegione =
        new SortedMap<String, int>(Ordering.byKey());

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      String sigla = element.area;

      int dosiTemp = 0;

      dosiTemp += (element.prima_dose);

      if (!somministrazioniRegione.containsKey(sigla)) {
        somministrazioniRegione.putIfAbsent(sigla, () => dosiTemp);
      } else {
        somministrazioniRegione.update(sigla, (value) => value + dosiTemp);
      }
    }

    return somministrazioniRegione;
  }

  //RITORNA UNA MAPPA CONTENTE IL NUMERO DI SECONDE SOMMISTRAZIONI PER REGIONE
  static Future<Map<String, int>> getSecondaSomministrazionePerRegione() async {
    var summary;

    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> somministrazioniRegione =
        new SortedMap<String, int>(Ordering.byKey());

    for (SomministrazioneVacciniSummaryLatest element in summary) {
      String sigla = element.area;

      int dosiTemp = 0;

      dosiTemp += (element.seconda_dose);

      if (!somministrazioniRegione.containsKey(sigla)) {
        somministrazioniRegione.putIfAbsent(sigla, () => dosiTemp);
      } else {
        somministrazioniRegione.update(sigla, (value) => value + dosiTemp);
      }
    }

    return somministrazioniRegione;
  }

  //RITORNA UNA LISTA DI CLASSE DI REGIONI CONTENTE LE INFORMAZIONI SULLE SOMMISTRAZIONI
  static Future<List<Regione>> graphInfoSomministrazioniPerRegione() async {
    var data;
    List<Regione> regioni = [];
    await SomministrazioneVacciniSummaryLatest.getListData()
        .then((value) => data = value);
    for (SomministrazioneVacciniSummaryLatest element in data) {
      var exist = regioni.where((f) => (f.sigla == element.area));
      if (exist.isEmpty) {
        regioni.add(Regione(
          nome: element.nome_regione,
          sigla: element.area,
          totaleDosiSommistrate: 0,
          primeDosi: element.prima_dose,
          secondeDosi: element.seconda_dose,
        ));
      } else {
        regioni.forEach((f) {
          if (f.sigla == element.area) {
            f.nome = element.nome_regione;
            f.sigla = element.area;
            f.primeDosi += element.prima_dose;
            f.secondeDosi += element.seconda_dose;
            f.totaleDosiSommistrate +=
                (element.prima_dose + element.seconda_dose);
          }
        });
      }
    }

    return regioni;
  }

  /// Restituisce i dati giorno per giorno per una regione.
  static Future<List<DatiRegioneGiornata>> getDatiRegioniGiornoPerGiorno(
      String area) async {
    var datiSomministrazioni =
        await SomministrazioneVacciniLatest.getListData();
    var datiConsegne = await ConsegneVacciniLatest.getListData();
    List<DatiRegioneGiornata> dati = [];

    for (SomministrazioneVacciniLatest element in datiSomministrazioni) {
      if (element.area != area) continue;
      DateTime date = DateTime.parse(element.data_somministrazione);
      Iterable<DatiRegioneGiornata> listaSel;

      if ((listaSel = dati.where((e) => e.data == date)).isEmpty) {
        var datiCur = DatiRegioneGiornata(date);
        datiCur.dosiSomministrate = element.prima_dose + element.seconda_dose;
        datiCur.vaccinati = element.seconda_dose;
        if (element.fornitore == "Janssen")
          datiCur.vaccinati += element.prima_dose;
        dati.add(datiCur);
      } else {
        assert(listaSel.length == 1);
        var datiCur = listaSel.first;
        datiCur.dosiSomministrate += element.prima_dose + element.seconda_dose;
        datiCur.vaccinati += element.seconda_dose;
        if (element.fornitore == "Janssen")
          datiCur.vaccinati += element.prima_dose;
        int i = dati.indexWhere((e) => e.data == date);
        dati[i] = datiCur;
      }
    }

    for (ConsegneVacciniLatest element in datiConsegne) {
      if (element.area != area) continue;
      DateTime date = DateTime.parse(element.data_consegna);
      int i = dati.indexWhere((e) => e.data == date);
      if (i == -1) {
        var datiCur = DatiRegioneGiornata(date);
        datiCur.dosiConsegnate = element.numero_dosi;
        dati.add(datiCur);
      } else {
        dati[i].dosiConsegnate += element.numero_dosi;
      }
    }

    return dati;
  }

  //RITORNA IL NUMERO DELLA DOSI CONSEGNATE OGGI
  static Future<UltimaConsegna> getUltimeDosiConsegnatePerRegione(
      String area) async {
    var summary;

    UltimaConsegna ultimaConsegna = new UltimaConsegna();

    ultimaConsegna.data = new DateTime(1979, 01, 01);

    await ConsegneVacciniLatest.getListData().then((value) => summary = value);

    for (ConsegneVacciniLatest element in summary) {
      if (element.area == area) {
        var dataTemp = element.data_consegna.substring(0, 10);
        List<String> splitDate = dataTemp.split("-");
        DateTime dataConsegna = new DateTime(int.parse(splitDate[0]),
            int.parse(splitDate[1]), int.parse(splitDate[2]));
        if (ultimaConsegna.data.isBefore(dataConsegna)) {
          ultimaConsegna = new UltimaConsegna(data: dataConsegna);
        }
      }
    }

    for (ConsegneVacciniLatest element in summary) {
      if (element.area == area) {
        var dataTemp = element.data_consegna.substring(0, 10);
        List<String> splitDate = dataTemp.split("-");
        DateTime dataConsegna = new DateTime(
          int.parse(splitDate[0]),
          int.parse(splitDate[1]),
          int.parse(splitDate[2]),
        );

        if (dataConsegna.day == ultimaConsegna.data.day &&
            dataConsegna.month == ultimaConsegna.data.month &&
            dataConsegna.year == ultimaConsegna.data.year) {
          if (ultimaConsegna.fornitori == null) {
            ultimaConsegna.fornitori = [];
            ultimaConsegna.fornitori.add(new Fornitore(element.fornitore,
                numeroDosi: element.numero_dosi));
          } else {
            int i = 0;
            bool exist = false;

            for (Fornitore f in ultimaConsegna.fornitori) {
              if (f.nome == element.fornitore) {
                exist = true;
                ultimaConsegna.fornitori[i].numeroDosi += element.numero_dosi;
              }
              i++;
            }

            if (!exist)
              ultimaConsegna.fornitori.add(new Fornitore(element.fornitore,
                  numeroDosi: element.numero_dosi));
          }
        }
      }
    }
    return ultimaConsegna;
  }

  //RITORNA IL NUMERO DELLA CONSEGNE DI DOSI PER GIORNO
  static Future<List<FlSpot>> graphConsegnePerGiornoPerRegione(
      String area) async {
    List<FlSpot> data = [];
    var summary;
    await ConsegneVacciniLatest.getListData().then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> consegnePerGiorno =
        new SortedMap<String, int>(Ordering.byKey());

    for (ConsegneVacciniLatest element in summary) {
      if (element.area == area) {
        String date = element.data_consegna.substring(0, 10);
        int tempTot = element.numero_dosi;

        if (!consegnePerGiorno.containsKey(date)) {
          consegnePerGiorno.putIfAbsent(date, () => tempTot);
        } else {
          consegnePerGiorno.update(date, (value) => value + tempTot);
        }
      }
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    if (!consegnePerGiorno.containsKey(formattedDate)) {
      consegnePerGiorno.putIfAbsent(formattedDate, () => 0);
    }

    consegnePerGiorno = _addZeroDays(consegnePerGiorno);

    consegnePerGiorno.forEach((key, value) {
      data.add(FlSpot(DateTime.parse(key).millisecondsSinceEpoch.toDouble(),
          value.toDouble()));
    });

    return data;
  }

  static Future<Map<String, int>> getConsegnePerRegione(String area) async {
    // int consegne = 0;
    // for (ConsegneVacciniLatest element
    //     in await ConsegneVacciniLatest.getListData()) {
    //   if (area == element.area) consegne += element.numero_dosi;
    // }
    // return consegne;
    var summary;
    await ConsegneVacciniLatest.getListData().then((value) => summary = value);
    //{'giorno':dosi}
    Map<String, int> consegnePerGiorno =
        new SortedMap<String, int>(Ordering.byKey());

    for (ConsegneVacciniLatest element in summary) {
      if (element.area == area) {
        String date = element.data_consegna.substring(0, 10);
        int tempTot = element.numero_dosi;

        if (!consegnePerGiorno.containsKey(date)) {
          consegnePerGiorno.putIfAbsent(date, () => tempTot);
        } else {
          consegnePerGiorno.update(date, (value) => value + tempTot);
        }
      }
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    if (!consegnePerGiorno.containsKey(formattedDate)) {
      consegnePerGiorno.putIfAbsent(formattedDate, () => 0);
    }

    consegnePerGiorno = _addZeroDays(consegnePerGiorno);

    return consegnePerGiorno;
  }

  static Map<String, int> _addZeroDays(Map<String, int> mapData) {
    Map<String, int> fullData = new SortedMap<String, int>(Ordering.byKey());
    var formatter = new DateFormat('yyyy-MM-dd');

    DateTime lastDate;
    bool firstTime = false;

    mapData.forEach((key, value) {
      fullData.putIfAbsent(key, () => value);
      if (!firstTime) {
        lastDate = DateTime.parse(key);
        firstTime = true;
      }
      if (!lastDate.isAtSameMomentAs(DateTime.parse(key)) &&
          lastDate.isBefore(DateTime.parse(key)))
        while (lastDate.isBefore(DateTime.parse(key))) {
          fullData.putIfAbsent(formatter.format(lastDate), () => 0);
          lastDate = lastDate.add(new Duration(days: 1));
        }
      lastDate = lastDate.add(new Duration(days: 1));
    });

    return fullData;
  }
}

class UltimaConsegna {
  DateTime data;
  List<Fornitore> fornitori = List<Fornitore>.empty();
  UltimaConsegna({
    this.data,
    this.fornitori,
  });
}

class Fornitore {
  String nome;
  int numeroDosi;
  double percentualeSuTot;

  Fornitore(this.nome, {this.numeroDosi = 0, this.percentualeSuTot = 0});
}

class Regione {
  String nome;
  String sigla;
  int totaleDosiSommistrate;
  int primeDosi;
  int secondeDosi;
  List<DatiRegioneGiornata> giornate;

  Regione(
      {this.nome,
      this.sigla,
      this.totaleDosiSommistrate,
      this.primeDosi,
      this.secondeDosi,
      this.giornate});
}

class UltimeSomministrazioni {
  DateTime data;
  int primaDose;
  int secondaDose;
  int dosiTotali;

  UltimeSomministrazioni({
    this.data,
    this.primaDose = 0,
    this.secondaDose = 0,
    this.dosiTotali = 0,
  });
}

class DatiRegioneGiornata {
  DatiRegioneGiornata(this.data);
  DateTime data;
  int dosiSomministrate = 0;
  int vaccinati = 0;
  int dosiConsegnate = 0;
}
