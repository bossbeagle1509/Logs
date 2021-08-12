import 'package:flutter/material.dart';

enum LogOption {
  edit,
  delete,
}

class OptionsMenu extends StatefulWidget {
  const OptionsMenu({Key? key}) : super(key: key);

  @override
  _OptionsMenuState createState() => _OptionsMenuState();
}

class _OptionsMenuState extends State<OptionsMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<LogOption>(
      tooltip: 'Options',
      onSelected: (_) => _popupMenuFunction(_),
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

_popupMenuFunction(LogOption _menuOption) {}
