import 'package:flutter/material.dart';
import 'package:nodelabs_case_study/product/constant/text.dart';
import 'package:nodelabs_case_study/product/theme/theme_manager.dart';

final class LightTheme implements ThemeManager {
  LightTheme({required this.isDarkMode});
  final bool isDarkMode;

  ThemeData get baseLightTheme => ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        fontFamily: TextConstants.mainFontFamily,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
      );

  @override
  ThemeData get theme => baseLightTheme.copyWith(
        appBarTheme: const AppBarTheme(scrolledUnderElevation: 0),
        textTheme: baseLightTheme.textTheme.copyWith(
          headlineLarge: baseLightTheme.textTheme.headlineLarge?.copyWith(
            fontFamily: TextConstants.mainFontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          bodyMedium: baseLightTheme.textTheme.bodyMedium?.copyWith(
            fontFamily: TextConstants.mainFontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
        ),
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData();
}
