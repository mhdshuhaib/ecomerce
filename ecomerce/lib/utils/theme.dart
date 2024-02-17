import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData applicationTheme(BuildContext context) {
  return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF6F6F6)),
      scaffoldBackgroundColor: kbackGround,
      brightness: Brightness.light,
      primaryColor: kprimaryColor,
      highlightColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      splashColor: Colors.transparent);
}
