import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme{
  static ThemeData dataTheme() => ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue[600],
  accentColor: Colors.amber[700],
  brightness: Brightness.light,
  backgroundColor: Colors.grey[100],
  textTheme: TextTheme(
    bodyText1: GoogleFonts.sourceSansPro(
      fontSize: 13,
    ),
      bodyText2: GoogleFonts.quicksand(
          fontSize: 13,
      )
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity
  );
}