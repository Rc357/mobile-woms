import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color(0xFFCD5E77);
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: COLOR_PRIMARY,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Roboco",
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
