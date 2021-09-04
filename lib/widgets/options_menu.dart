import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
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
  changeColor,
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
          child: Text('View Logs'),
        ),
        const PopupMenuItem<LogOption>(
          value: LogOption.changeColor,
          child: Text('Change Color'),
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

    Get.dialog(
      DisplayLogDialog(logToDisplay: logBox.getAt(keyIndex)!),
    );
  } else if (menuOption == LogOption.changeColor) {
    Get.dialog(
      Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 320,
          width: 450,
          child: MaterialColorPicker(
            allowShades: false,
            onMainColorChange: (ColorSwatch? color) {
              HiveDB _hiveDB = HiveDB();
              _hiveDB.updateColor(
                index: keyIndex,
                color: color!.value,
              );

              Get.back();
            },
            selectedColor: Colors.grey,
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
