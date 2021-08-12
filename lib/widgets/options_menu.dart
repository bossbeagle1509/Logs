import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logs/models/hive_db.dart';
import 'package:logs/models/log.dart';
import 'package:logs/widgets/accept_log_dialog.dart';

enum LogOption {
  edit,
  delete,
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
      ],
    );
  }
}

_popupMenuFunction({
  required LogOption menuOption,
  required int keyIndex,
}) {
  final HiveDB _hiveDB = HiveDB();

  print(keyIndex);

  if (menuOption == LogOption.delete) {
    _hiveDB.deleteLog(keyIndex);
  } else {
    var logBox = Hive.box<Log>('logs');

    // print('got ' + logBox.getAt(keyIndex)!.hours.toString());

    Get.dialog(
      AcceptLogDialog(
        isThisAnUpdate: true,
        keyIndexToUpdateAt: keyIndex,
        loggedHours: logBox.getAt(keyIndex)!.hours,
        name: logBox.getAt(keyIndex)!.name,
      ),
    );
  }
}
