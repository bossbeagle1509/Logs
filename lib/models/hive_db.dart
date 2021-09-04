import 'package:flutter/material.dart' show Color, Colors;
import 'package:hive/hive.dart';
import 'log.dart';

class HiveDB {
  addNewLog({required String logName, required double hours}) {
    var logBox = Hive.box<Log>('logs');

    logBox.add(
      Log(
        name: logName,
        hours: hours,
        dateLog: {DateTime.now(): 'Log init with $hours'},
        logColorAsInt: Colors.white.value,
      ),
    );
  }

  updateLog({
    required int index,
    required Log newLog,
  }) {
    try {
      var logBox = Hive.box<Log>('logs');
      logBox.putAt(index, newLog);

      print('completed update successfully');
    } catch (e) {
      rethrow;
    }
  }

  updateColor({
    required int index,
    required int color,
  }) {
    try {
      var logBox = Hive.box<Log>('logs');

      Log oldLog = logBox.getAt(index)!;
      oldLog.logColorAsInt = color;
      logBox.putAt(index, oldLog);

      print('completed update successfully');
    } catch (e) {
      rethrow;
    }
  }

  incrementHoursSpent(int indexOfKey) {
    var logBox = Hive.box<Log>('logs');
    Log oldLog = logBox.getAt(indexOfKey)!;

    oldLog.hours++;
    oldLog.dateLog.putIfAbsent(
      DateTime.now(),
      () => '+' + oldLog.hours.toString(),
    );

    logBox.putAt(indexOfKey, oldLog);
  }

  decrementHoursSpent(int indexOfKey) {
    var logBox = Hive.box<Log>('logs');
    Log oldLog = logBox.getAt(indexOfKey)!;

    if (oldLog.hours <= 0) {
      return;
    }

    oldLog.hours--;
    oldLog.dateLog.putIfAbsent(
      DateTime.now(),
      () => '-' + oldLog.hours.toString(),
    );

    logBox.putAt(indexOfKey, oldLog);
  }

  deleteLog(int key) {
    var logBox = Hive.box<Log>('logs');

    try {
      logBox.deleteAt(key);

      print('deleted successfully');
    } catch (e) {
      rethrow;
    }
  }
}
