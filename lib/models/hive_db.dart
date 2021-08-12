import 'package:hive/hive.dart';
import 'package:logs/models/log.dart';

class HiveDB {
  Future<void> addNewLog(
      {required String logName, required double hours}) async {
    var logBox = Hive.box<Log>('logs');

    logBox.add(
      Log(name: logName, hours: hours),
    );
  }

  Future<void> updateLog({
    required int index,
    required Log newLog,
  }) async {
    try {
      var logBox = Hive.box<Log>('logs');
      logBox.putAt(index, newLog);

      print('completed update successfully');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteLog(int key) async {
    var logBox = Hive.box<Log>('logs');

    try {
      logBox.deleteAt(key);

      print('deleted successfully');
    } catch (e) {
      rethrow;
    }
  }
}
