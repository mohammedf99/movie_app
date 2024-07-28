import 'package:flutter/material.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff0d1b2a),
);

const white = Color(0xFFD3D3D3);

const textStyleColor = TextStyle(
  color: white,
);

final themeData = ThemeData(
  scaffoldBackgroundColor: const Color(0xff0d1b2a).withOpacity(0.75),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff0d1b2a),
    foregroundColor: Color(0xffD3D3D3),
  ),
  textTheme: const TextTheme(
    titleLarge: textStyleColor,
    titleMedium: textStyleColor,
    titleSmall: textStyleColor,
    bodyLarge: textStyleColor,
    bodyMedium: textStyleColor,
    bodySmall: textStyleColor,
  ),
  listTileTheme: const ListTileThemeData(
    titleTextStyle: TextStyle(
      color: white,
      fontWeight: FontWeight.w700,
    ),
    subtitleTextStyle: TextStyle(
      color: Color(0xffD6D6D6),
    ),
  ),
  iconTheme: const IconThemeData(
    size: 32.0,
    color: white,
  ),
);
