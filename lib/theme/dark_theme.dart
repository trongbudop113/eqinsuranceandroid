import 'package:flutter/material.dart';

class DarkTheme{
  static ThemeData dataTheme() => ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue[300],
    accentColor: Colors.amber,
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[900],
    fontFamily: 'Karla',
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}