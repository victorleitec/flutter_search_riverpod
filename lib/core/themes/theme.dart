import 'package:flutter/material.dart';

const seedColor = Colors.red;

final themeData = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
);

final colorScheme = ColorScheme.fromSeed(
  seedColor: seedColor,
);
