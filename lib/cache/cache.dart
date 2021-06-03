import 'package:path_provider/path_provider.dart';
import 'package:statusvaccini/Models/opendata.dart';
import 'dart:io' show File;

const latestUpdateFileName = "latest_update.txt";

class Cache<T> {
  // al momento l'unica cosa che fa il tipo è salvare tipi diversi in file diversi
  String filename = T.toString(); // dovrebbe essere il nome del tipo
  Future<bool> needsUpdate() async {
    File file = File(
        '${(await getApplicationDocumentsDirectory()).path}/$filename.txt');
    if (!(await file.exists())) return true;
    var remoteDate = await OpenData.getLastUpdateData();
    var content = int.parse(await file.readAsString());
    if (content != remoteDate.millisecondsSinceEpoch)
      return true;
    else
      return false;
  }

  Future<void> update(DateTime latestUpdate, String data) async {
    File updateFile = File(
        '${(await getApplicationDocumentsDirectory()).path}/$filename.txt');
    File dataFile = File(
        '${(await getApplicationDocumentsDirectory()).path}/$filename.json');
    await dataFile.writeAsString(data);
    await updateFile.writeAsString("${latestUpdate.millisecondsSinceEpoch}");
  }

  Future<String> getData() async {
    File file = File(
        '${(await getApplicationDocumentsDirectory()).path}/$filename.json');

    return await file.readAsString();
  }
}
