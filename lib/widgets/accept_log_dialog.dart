import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logs/models/hive_db.dart';
import 'package:logs/models/log.dart';

class AcceptLogDialog extends StatefulWidget {
  final bool isThisAnUpdate;

  /// Index of the key
  final int? keyIndexToUpdateAt;

  // from an already existing log
  final double? loggedHours;
  final String? name;

  const AcceptLogDialog({
    Key? key,
    this.isThisAnUpdate = false,
    this.keyIndexToUpdateAt,
    this.name,
    this.loggedHours,
  }) : super(key: key);

  @override
  _AcceptLogDialogState createState() => _AcceptLogDialogState();
}

class _AcceptLogDialogState extends State<AcceptLogDialog> {
  final HiveDB _hiveDB = HiveDB();
  late String logName;
  late double logHours;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _loggedHoursController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isThisAnUpdate) {
      _nameController.text = widget.name!;
      _loggedHoursController.text = widget.loggedHours!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          color: Theme.of(context).primaryColor,
          height: 300,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ),
              // title
              const Text(
                'Add a Log',
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    border: UnderlineInputBorder(),
                    labelText: 'Name the log',
                  ),
                  onChanged: (value) {
                    logName = value;
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: _loggedHoursController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    border: UnderlineInputBorder(),
                    labelText: 'How much time did you spend ?',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    logHours = double.parse(value);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 100,
                  height: 40,
                  child: TextButton(
                    style:
                        // flatButtonStyle,
                        ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.amber[800]!,
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.amber[600],
                      ),
                    ),
                    onPressed: () async {
                      widget.isThisAnUpdate
                          ? await _hiveDB.updateLog(
                              index: widget.keyIndexToUpdateAt!,
                              newLog: Log(
                                hours:
                                    double.parse(_loggedHoursController.text),
                                name: _nameController.text,
                              ),
                            )
                          : await _hiveDB.addNewLog(
                              logName: logName,
                              hours: logHours,
                            );

                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
