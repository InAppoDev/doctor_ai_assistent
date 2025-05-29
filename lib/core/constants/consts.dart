import 'package:flutter/material.dart';

import 'app_colors.dart';

final navigatorKey = GlobalKey<NavigatorState>();

const List<String> medicalForms = ['Progress Notes', 'H&P form'];

const speakerColors = [
  AppColors.accentGreen,
  AppColors.accentBlue,
  AppColors.accentPink,
  AppColors.accentYellow,
  Colors.deepOrangeAccent,
  Colors.deepPurple,
];

const supportedLocales = [
  Locale('af', 'ZA'), // Afrikaans
  Locale('ar', 'AE'), // Arabic (Gulf)
  Locale('ar', 'SA'), // Arabic (Modern Standard)
  Locale('eu', 'ES'), // Basque
  Locale('ca', 'ES'), // Catalan
  Locale('zh', 'HK'), // Chinese (Cantonese), Hong-Kong
  Locale('zh', 'CN'), // Chinese, Simplified
  Locale('zh', 'TW'), // Chinese, Traditional
  Locale('hr', 'HR'), // Croatian
  Locale('cs', 'CZ'), // Czech
  Locale('da', 'DK'), // Danish
  Locale('nl', 'NL'), // Dutch
  Locale('en', 'AU'), // English (Australian)
  Locale('en', 'GB'), // English (British)
  Locale('en', 'IN'), // English (Indian)
  Locale('en', 'IE'), // English (Irish)
  Locale('en', 'NZ'), // English (New Zealand)
  Locale('en', 'AB'), // English (Scottish)
  Locale('en', 'ZA'), // English (South African)
  Locale('en', 'US'), // English (US)
  Locale('en', 'WL'), // English (Welsh)
  Locale('fa', 'IR'), // Farsi
  Locale('fi', 'FI'), // Finnish
  Locale('fr', 'FR'), // French (France)
  Locale('fr', 'CA'), // French (Canadian)
  Locale('gl', 'ES'), // Galician
  Locale('de', 'DE'), // German
  Locale('de', 'CH'), // German (Swiss)
  Locale('el', 'GR'), // Greek
  Locale('he', 'IL'), // Hebrew
  Locale('hi', 'IN'), // Hindi
  Locale('id', 'ID'), // Indonesian
  Locale('it', 'IT'), // Italian
  Locale('ja', 'JP'), // Japanese
  Locale('ko', 'KR'), // Korean
  Locale('lv', 'LV'), // Latvian
  Locale('ms', 'MY'), // Malay
  Locale('no', 'NO'), // Norwegian
  Locale('pl', 'PL'), // Polish
  Locale('pt', 'BR'), // Portuguese (Brazilian)
  Locale('ro', 'RO'), // Romanian
  Locale('ru', 'RU'), // Russian
  Locale('sr', 'RS'), // Serbian
  Locale('sk', 'SK'), // Slovak
  Locale('so', 'SO'), // Somali
  Locale('es', 'ES'), // Spanish (Spain)
  Locale('es', 'US'), // Spanish (US)
  Locale('sv', 'SE'), // Swedish
  Locale('tl', 'PH'), // Tagalog/Filipino
  Locale('th', 'TH'), // Thai
  Locale('uk', 'UA'), // Ukrainian
  Locale('vi', 'VN'), // Vietnamese
  Locale('zu', 'ZA'), // Zulu
];
