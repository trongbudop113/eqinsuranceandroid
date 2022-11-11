import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyleResource{
  static TextStyle TextStyleBlack(BuildContext context) => Theme.of(context).textTheme.bodyText1!;
  static TextStyle TextStyleQuickSand(BuildContext context) => Theme.of(context).textTheme.bodyText2!;
}