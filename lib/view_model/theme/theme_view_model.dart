import 'dart:ui';

import 'package:nodelabs_case_study/product/base/base_cubit.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends BaseCubit<ThemeState> {
  ThemeViewModel() : super(const ThemeState(isDark: false)) {
    _loadThemeFromPersistance();
  }

  static const String _themeKey = 'isDarkMode';

  Future<void> _loadThemeFromPersistance() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getBool(_themeKey);

    if (savedTheme == null) {
      final isSystemDark =
          PlatformDispatcher.instance.platformBrightness == Brightness.dark;
      emit(state.copyWith(isDark: isSystemDark));
    } else {
      emit(state.copyWith(isDark: savedTheme));
    }
  }

  Future<void> changeTheme() async {
    final newTheme = !state.isDark;
    emit(state.copyWith(isDark: newTheme));
    await _saveTheme(newTheme);
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }
}
