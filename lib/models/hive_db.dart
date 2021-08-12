import 'package:hive/hive.dart';
import 'package:logs/models/log.dart';

class HiveDB {
  Future<void> addNewLog(
      {required String logName, required double hours}) async {
    var logBox = await Hive.openBox<Log>('logs');

    logBox.add(
      Log(name: logName, hours: hours),
    );
  }

  Future<void> readLog(int index) async {
    var logBox = await Hive.openBox<Log>('logs');
  }

  Future<void> updateLog(int index, {double? newValue}) async {
    try {
      var logBox = await Hive.openBox<Log>('logs');
      Log existingLog = logBox.getAt(index)!;
      existingLog.hours++;
      logBox.putAt(index, existingLog);

      print('completed updae successfully');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteLog(int key) async {
    var logBox = Hive.box<Log>('logs');

    try {
      logBox.delete(key);

      print('deleted successfully');
    } catch (e) {
      rethrow;
    }
  }
}
