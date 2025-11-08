class AppConstants {
  // App info
  static const String appName = 'El Dorado Track';
  static const String appVersion = '1.0.1';
  static const String appMotto = 'Track your treasures, discover your wealth';

  // Database
  static const String databaseName = 'el_dorado_track.db';
  static const int databaseVersion = 1;
  static const String entriesTableName = 'treasure_entries';

  // SharedPreferences keys
  static const String keyAnimationsEnabled = 'animations_enabled';
  static const String keyFirstLaunch = 'first_launch';
  static const String keyStreakCount = 'streak_count';
  static const String keyLastEntryDate = 'last_entry_date';
  static const String keyTotalTreasures = 'total_treasures';
  static const String keyCurrentLevel = 'current_level';
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const bool debugForceOnboarding = false;

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);

  // UI constants
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const double buttonHeight = 48.0;
  static const double iconSize = 24.0;
  static const double largeIconSize = 32.0;

  // Text limits
  static const int maxTreasureTextLength = 500;
  static const int maxTagsPerEntry = 5;

  // Export
  static const String exportFileName = 'treasure_entries_export.json';
  static const String exportDateFormat = 'yyyy-MM-dd_HH-mm-ss';

  // El Dorado specific constants
  static const int treasuresPerLevel = 10;
  static const int maxLevel = 100;
  static const List<String> treasureTypes = [
    'gold',
    'jewelry',
    'artifacts',
    'coins',
    'gems',
    'other',
  ];
}
