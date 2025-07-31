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
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.white,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
        ),
      );

  @override
  ThemeData get theme => baseDarkTheme;

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData();
}
