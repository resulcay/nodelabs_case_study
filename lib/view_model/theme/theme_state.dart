final class ThemeState {
  const ThemeState({
    required this.isDark,
  });

  final bool isDark;

  ThemeState copyWith({bool? isDark}) {
    return ThemeState(
      isDark: isDark ?? this.isDark,
    );
  }
}
