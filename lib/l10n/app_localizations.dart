import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // App info
  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get appMotto => _localizedValues[locale.languageCode]!['appMotto']!;

  // Navigation
  String get today => _localizedValues[locale.languageCode]!['today']!;
  String get treasures => _localizedValues[locale.languageCode]!['treasures']!;
  String get insights => _localizedValues[locale.languageCode]!['insights']!;
  String get achievements => _localizedValues[locale.languageCode]!['achievements']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;

  // Today screen
  String get whatTreasuresDidYouFind => _localizedValues[locale.languageCode]!['whatTreasuresDidYouFind']!;
  String get addYourFirstTreasure => _localizedValues[locale.languageCode]!['addYourFirstTreasure']!;
  String get todaysTreasures => _localizedValues[locale.languageCode]!['todaysTreasures']!;
  String get emptyTreasureChest => _localizedValues[locale.languageCode]!['emptyTreasureChest']!;
  String get addTreasureDescription => _localizedValues[locale.languageCode]!['addTreasureDescription']!;

  // Treasure types
  String get gold => _localizedValues[locale.languageCode]!['gold']!;
  String get jewelry => _localizedValues[locale.languageCode]!['jewelry']!;
  String get artifacts => _localizedValues[locale.languageCode]!['artifacts']!;
  String get coins => _localizedValues[locale.languageCode]!['coins']!;
  String get gems => _localizedValues[locale.languageCode]!['gems']!;
  String get other => _localizedValues[locale.languageCode]!['other']!;

  // Add entry screen
  String get addNewTreasure => _localizedValues[locale.languageCode]!['addNewTreasure']!;
  String get treasureDescription => _localizedValues[locale.languageCode]!['treasureDescription']!;
  String get selectTreasureTypes => _localizedValues[locale.languageCode]!['selectTreasureTypes']!;
  String get treasureValue => _localizedValues[locale.languageCode]!['treasureValue']!;
  String get saveTreasure => _localizedValues[locale.languageCode]!['saveTreasure']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;

  // Insights screen
  String get yourProgress => _localizedValues[locale.languageCode]!['yourProgress']!;
  String get totalTreasures => _localizedValues[locale.languageCode]!['totalTreasures']!;
  String get currentLevel => _localizedValues[locale.languageCode]!['currentLevel']!;
  String get treasuresToNextLevel => _localizedValues[locale.languageCode]!['treasuresToNextLevel']!;
  String get currentStreak => _localizedValues[locale.languageCode]!['currentStreak']!;
  String get days => _localizedValues[locale.languageCode]!['days']!;

  // Achievements screen
  String get yourAchievements => _localizedValues[locale.languageCode]!['yourAchievements']!;
  String get unlocked => _localizedValues[locale.languageCode]!['unlocked']!;
  String get locked => _localizedValues[locale.languageCode]!['locked']!;
  String get progress => _localizedValues[locale.languageCode]!['progress']!;

  // Settings screen
  String get preferences => _localizedValues[locale.languageCode]!['preferences']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get animations => _localizedValues[locale.languageCode]!['animations']!;
  String get exportData => _localizedValues[locale.languageCode]!['exportData']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;

  // Common
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get close => _localizedValues[locale.languageCode]!['close']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
  String get yes => _localizedValues[locale.languageCode]!['yes']!;
  String get no => _localizedValues[locale.languageCode]!['no']!;

  // Month names
  String getMonthName(int month) {
    final months = _localizedValues[locale.languageCode]!['months'] as List<String>;
    return months[month - 1];
  }

  static final Map<String, Map<String, dynamic>> _localizedValues = {
    'en': {
      'appName': 'El Dorado Track',
      'appMotto': 'Track your treasures, discover your wealth',
      'today': 'Today',
      'treasures': 'Treasures',
      'insights': 'Insights',
      'achievements': 'Achievements',
      'settings': 'Settings',
      'whatTreasuresDidYouFind': 'What treasures did you find today?',
      'addYourFirstTreasure': 'Add your first treasure to start your collection!',
      'todaysTreasures': 'Today\'s Treasures',
      'emptyTreasureChest': 'Empty Treasure Chest',
      'addTreasureDescription': 'Add your first treasure to start filling your chest with riches.',
      'gold': 'Gold',
      'jewelry': 'Jewelry',
      'artifacts': 'Artifacts',
      'coins': 'Coins',
      'gems': 'Gems',
      'other': 'Other',
      'addNewTreasure': 'Add New Treasure',
      'treasureDescription': 'Describe your treasure...',
      'selectTreasureTypes': 'Select treasure types',
      'treasureValue': 'Treasure Value',
      'saveTreasure': 'Save Treasure',
      'cancel': 'Cancel',
      'yourProgress': 'Your Progress',
      'totalTreasures': 'Total Treasures',
      'currentLevel': 'Current Level',
      'treasuresToNextLevel': 'Treasures to Next Level',
      'currentStreak': 'Current Streak',
      'days': 'days',
      'yourAchievements': 'Your Achievements',
      'unlocked': 'Unlocked',
      'locked': 'Locked',
      'progress': 'Progress',
      'preferences': 'Preferences',
      'language': 'Language',
      'theme': 'Theme',
      'animations': 'Animations',
      'exportData': 'Export Data',
      'about': 'About',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'close': 'Close',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',
      'months': [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ],
    },
    'es': {
      'appName': 'El Dorado Track',
      'appMotto': 'Rastrea tus tesoros, descubre tu riqueza',
      'today': 'Hoy',
      'treasures': 'Tesoros',
      'insights': 'Estadísticas',
      'achievements': 'Logros',
      'settings': 'Configuración',
      'whatTreasuresDidYouFind': '¿Qué tesoros encontraste hoy?',
      'addYourFirstTreasure': '¡Agrega tu primer tesoro para comenzar tu colección!',
      'todaysTreasures': 'Tesoros de Hoy',
      'emptyTreasureChest': 'Cofre de Tesoros Vacío',
      'addTreasureDescription': 'Agrega tu primer tesoro para comenzar a llenar tu cofre con riquezas.',
      'gold': 'Oro',
      'jewelry': 'Joyas',
      'artifacts': 'Artefactos',
      'coins': 'Monedas',
      'gems': 'Gemas',
      'other': 'Otro',
      'addNewTreasure': 'Agregar Nuevo Tesoro',
      'treasureDescription': 'Describe tu tesoro...',
      'selectTreasureTypes': 'Selecciona tipos de tesoro',
      'treasureValue': 'Valor del Tesoro',
      'saveTreasure': 'Guardar Tesoro',
      'cancel': 'Cancelar',
      'yourProgress': 'Tu Progreso',
      'totalTreasures': 'Total de Tesoros',
      'currentLevel': 'Nivel Actual',
      'treasuresToNextLevel': 'Tesoros para el Siguiente Nivel',
      'currentStreak': 'Racha Actual',
      'days': 'días',
      'yourAchievements': 'Tus Logros',
      'unlocked': 'Desbloqueados',
      'locked': 'Bloqueados',
      'progress': 'Progreso',
      'preferences': 'Preferencias',
      'language': 'Idioma',
      'theme': 'Tema',
      'animations': 'Animaciones',
      'exportData': 'Exportar Datos',
      'about': 'Acerca de',
      'save': 'Guardar',
      'delete': 'Eliminar',
      'edit': 'Editar',
      'close': 'Cerrar',
      'ok': 'OK',
      'yes': 'Sí',
      'no': 'No',
      'months': [
        'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
        'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
      ],
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

