import 'package:flutter/material.dart';
import 'package:nodelabs_case_study/product/constant/text.dart';
import 'package:nodelabs_case_study/product/theme/theme_manager.dart';

final class DarkTheme implements ThemeManager {
  DarkTheme({required this.isDarkMode});
  final bool isDarkMode;

  ThemeData get baseDarkTheme => ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        fontFamily: TextConstants.mainFontFamily,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
      );

  @override
  ThemeData get theme => baseDarkTheme;

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData();
}
