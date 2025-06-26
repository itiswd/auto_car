class SimpleLocalization {
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Smart Car Controller',
      'settings': 'Settings',
      'darkMode': 'Dark Mode',
      'language': 'Language',
      'english': 'English',
      'arabic': 'Arabic',
    },
    'ar': {
      'appTitle': 'التحكم الذكي في السيارة',
      'settings': 'الإعدادات',
      'darkMode': 'الوضع الليلي',
      'language': 'اللغة',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
    },
  };

  static String getText(String key, String langCode) {
    return _localizedValues[langCode]?[key] ?? key;
  }
}
