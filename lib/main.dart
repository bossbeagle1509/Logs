import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logs/models/log.dart';
import 'package:logs/screens/home.dart';
import 'package:logs/themes.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> main() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(LogAdapter());

  await Hive.openBox<Log>('logs');
  await Hive.openBox('settings');

  isDarkModeEnabled.value = Hive.box('settings').get('darkMode', defaultValue: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<dynamic>(
      valueListenable: Hive.box<dynamic>('settings').listenable(),
      builder: (context, box, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Logs',
        theme: box.get('darkMode', defaultValue: true)
            ? logDarkMode
            : logLightMode,
        home: const Home(),
      ),
    );
  }
}
