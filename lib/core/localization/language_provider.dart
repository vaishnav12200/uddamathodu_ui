import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  bool get isEnglish => _locale.languageCode == 'en';
  bool get isMalayalam => _locale.languageCode == 'ml';

  String get currentLanguageName => isEnglish ? 'English' : 'മലയാളം';
  String get currentLanguageCode => isEnglish ? 'EN' : 'ML';

  void setEnglish() {
    _locale = const Locale('en');
    notifyListeners();
  }

  void setMalayalam() {
    _locale = const Locale('ml');
    notifyListeners();
  }

  void toggleLanguage() {
    if (isEnglish) {
      setMalayalam();
    } else {
      setEnglish();
    }
  }

  void setLocale(Locale locale) {
    if (!['en', 'ml'].contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
  }
}
