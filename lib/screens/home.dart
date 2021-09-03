import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logs/models/hive_db.dart';
import 'package:logs/models/log.dart';
import 'package:logs/widgets/accept_log_dialog.dart';
import 'package:logs/widgets/options_menu.dart';

import '../themes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    openBox();
  }

  void openBox() async {
    await Hive.openBox<Log>('logs');
  }

  final HiveDB _hiveDB = HiveDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Logs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.changeTheme(
                isDarkModeEnabled.value ? logLightMode : logDarkMode,
              );

              isDarkModeEnabled.value = !isDarkModeEnabled.value;

              Hive.box('settings').put('darkMode', isDarkModeEnabled.value);
            },
            icon: Obx(
              () => Icon(
                isDarkModeEnabled.value ? Icons.light_mode : Icons.dark_mode,
                color:
                    isDarkModeEnabled.value ? Colors.white : Colors.grey[900],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              Get.dialog(
                const AcceptLogDialog(),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Log>>(
        valueListenable: Hive.box<Log>('logs').listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No logs yet ! Try adding some :)'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: box.length,
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 5,
                //   crossAxisSpacing: 5,
                //   mainAxisSpacing: 5,
                // ),

                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 270,
                  mainAxisExtent: 250,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (ctx, index) => Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: OptionsMenu(
                            index: index,
                          ),
                        ),
                        Text(
                          box.getAt(index)!.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          // for my OCD
                          box.getAt(index)!.hours > 1
                              ? box.getAt(index)!.hours.toString() +
                                  ' hours spent'
                              : box.getAt(index)!.hours.toString() +
                                  ' hour spent',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  _hiveDB.decrementHoursSpent(index),
                              icon: const Icon(Icons.remove),
                            ),
                            IconButton(
                              onPressed: () =>
                                  _hiveDB.incrementHoursSpent(index),
                              icon: const Icon(Icons.add),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
