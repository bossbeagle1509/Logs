import 'package:flutter/material.dart';
import 'package:get/get.dart';

var isDarkModeEnabled = true.obs;

ThemeData logDarkMode = ThemeData.dark().copyWith(
  primaryColor: Colors.teal,
  accentColor: Colors.amber,
  primaryTextTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.teal,
  ),
);

ThemeData logLightMode = ThemeData.light().copyWith(
  primaryColor: Colors.teal,
  accentColor: Colors.amber,
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.teal,
  ),
);

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);
