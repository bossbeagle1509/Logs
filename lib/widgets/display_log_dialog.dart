import 'package:intl/intl.dart';
import 'package:logs/models/log.dart';
import 'package:flutter/material.dart';

class DisplayLogDialog extends StatelessWidget {
  final Log logToDisplay;

  const DisplayLogDialog({
    Key? key,
    required this.logToDisplay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          height: 320,
          width: 450,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Theme.of(context).primaryColor,
            child: ListView.builder(
              itemCount: logToDisplay.dateLog.length,
              itemBuilder: (ctx, index) => ListTile(
                leading: Text(
                  DateFormat("E, d MMMM y, hh:mm a").format(
                    logToDisplay.dateLog.keys.elementAt(index),
                  ),
                ),
                trailing: Text(
                  logToDisplay.dateLog.values.elementAt(index) + '  hour(s)',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
