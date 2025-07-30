import 'package:flutter/material.dart';

enum Locales {
  enUS(Locale('en', 'US')), // English - United States
  trTR(Locale('tr', 'TR')); // Turkish - Turkey

  const Locales(this.locale);
  final Locale locale;
}
