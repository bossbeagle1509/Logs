import 'package:flutter/material.dart';
import 'package:logs/models/hive_db.dart';

enum LogOption {
  edit,
  delete,
}

class OptionsMenu extends StatelessWidget {
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
        key: index,
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
  required int key,
}) {
  final HiveDB _hiveDB = HiveDB();

  print(key);

  if (menuOption == LogOption.delete) {
    _hiveDB.deleteLog(key);
  }
}
