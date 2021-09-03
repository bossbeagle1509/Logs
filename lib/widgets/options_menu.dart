import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logs/models/hive_db.dart';
import 'package:logs/models/log.dart';
import 'package:logs/widgets/accept_log_dialog.dart';
import 'package:logs/widgets/display_log_dialog.dart';

enum LogOption {
  edit,
  delete,
  view,
}

class OptionsMenu extends StatelessWidget {
  /// Index of the key
  final int index;

  const OptionsMenu({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<LogOption>(
      tooltip: 'Options',
      onSelected: (_) => _popupMenuFunction(
        keyIndex: index,
        menuOption: _,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<LogOption>>[
        const PopupMenuItem<LogOption>(
          value: LogOption.edit,
          child: Text('Edit Log'),
        ),
        const PopupMenuItem<LogOption>(
          value: LogOption.delete,
          child: Text('Delete Log'),
        ),
        const PopupMenuItem<LogOption>(
          value: LogOption.view,
          child: Text('View Log'),
        ),
      ],
    );
  }
}

_popupMenuFunction({
  required LogOption menuOption,
  required int keyIndex,
}) {
  final HiveDB _hiveDB = HiveDB();

  if (menuOption == LogOption.delete) {
    _hiveDB.deleteLog(keyIndex);
  } else if (menuOption == LogOption.edit) {
    var logBox = Hive.box<Log>('logs');

    Get.dialog(
      AcceptLogDialog(
        isThisAnUpdate: true,
        keyIndexToUpdateAt: keyIndex,
        loggedHours: logBox.getAt(keyIndex)!.hours,
        name: logBox.getAt(keyIndex)!.name,
        dateLog: logBox.getAt(keyIndex)!.dateLog,
      ),
    );
  } else if (menuOption == LogOption.view) {
    var logBox = Hive.box<Log>('logs');
    print(logBox.getAt(keyIndex)!);

    Get.dialog(
      DisplayLogDialog(logToDisplay: logBox.getAt(keyIndex)!),
    );
  }
}
