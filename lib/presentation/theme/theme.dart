import 'package:flutter/material.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff0d1b2a),
);

const textStyleColor = TextStyle(
  color: Color(0xffD3D3D3),
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
      color: Color(0xffD3D3D3),
      fontWeight: FontWeight.w700,
    ),
    subtitleTextStyle: TextStyle(
      color: Color(0xffD6D6D6),
    ),
  ),
  iconTheme: const IconThemeData(
    size: 32.0,
    color: Color(0xffD3D3D3),
  ),
);
