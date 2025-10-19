import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/treasure_entry.dart';
import '../models/achievement.dart';
import '../services/database_service.dart';
import '../services/achievement_service.dart';
import '../constants/app_constants.dart';

class TreasureProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final AchievementService _achievementService = AchievementService();
  
  List<TreasureEntry> _entries = [];
  bool _isLoading = false;
  bool _animationsEnabled = true;
  int _currentStreak = 0;
  Map<TreasureType, int> _treasureTypeStatistics = {};
  List<Achievement> _newAchievements = [];
  int _totalTreasures = 0;
  int _currentLevel = 1;

  // Getters
  List<TreasureEntry> get entries => _entries;
  bool get isLoading => _isLoading;
  bool get animationsEnabled => _animationsEnabled;
  int get currentStreak => _currentStreak;
  Map<TreasureType, int> get treasureTypeStatistics => _treasureTypeStatistics;
  int get totalEntries => _entries.length;
  int get totalTreasures => _totalTreasures;
  int get currentLevel => _currentLevel;
  List<Achievement> get newAchievements => _newAchievements;
  AchievementService get achievementService => _achievementService;

  // Initialize the provider
  Future<void> initialize() async {
    await _loadSettings();
    await _achievementService.initialize();
    
    // Delete old database to recreate with correct schema
    try {
      await _databaseService.deleteOldDatabase();
    } catch (e) {
      debugPrint('Error deleting old database: $e');
    }
    
    await loadEntries();
  }

  // Load entries from database
  Future<void> loadEntries() async {
    _isLoading = true;
    notifyListeners();

    try {
      _entries = await _databaseService.getAllTreasureEntries();
      _calculateStatistics();
      _updateStreak();
      await _checkAchievements();
    } catch (e) {
      debugPrint('Error loading entries: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new treasure entry
  Future<void> addTreasureEntry(TreasureEntry entry) async {
    try {
      await _databaseService.insertTreasureEntry(entry);
      _entries.add(entry);
      _calculateStatistics();
      _updateStreak();
      await _checkAchievements();
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding treasure entry: $e');
    }
  }

  // Update an existing treasure entry
  Future<void> updateTreasureEntry(TreasureEntry entry) async {
    try {
      await _databaseService.updateTreasureEntry(entry);
      final index = _entries.indexWhere((e) => e.id == entry.id);
      if (index != -1) {
        _entries[index] = entry;
        _calculateStatistics();
        await _checkAchievements();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating treasure entry: $e');
    }
  }

  // Delete a treasure entry
  Future<void> deleteTreasureEntry(String id) async {
    try {
      await _databaseService.deleteTreasureEntry(id);
      _entries.removeWhere((e) => e.id == id);
      _calculateStatistics();
      _updateStreak();
      await _checkAchievements();
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting treasure entry: $e');
    }
  }

  // Get entries for today
  List<TreasureEntry> getTodayEntries() {
    final today = DateTime.now();
    return _entries.where((entry) {
      final entryDate = DateTime(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day);
      final todayDate = DateTime(today.year, today.month, today.day);
      return entryDate.isAtSameMomentAs(todayDate);
    }).toList();
  }

  // Check if user has entry for today
  bool hasEntryForToday() {
    return getTodayEntries().isNotEmpty;
  }

  // Get entries by date range
  List<TreasureEntry> getEntriesByDateRange(DateTime start, DateTime end) {
    return _entries.where((entry) {
      return entry.createdAt.isAfter(start) && entry.createdAt.isBefore(end);
    }).toList();
  }

  // Get entries by treasure type
  List<TreasureEntry> getEntriesByType(TreasureType type) {
    return _entries.where((entry) => entry.types.contains(type)).toList();
  }

  // Calculate statistics
  void _calculateStatistics() {
    _treasureTypeStatistics.clear();
    _totalTreasures = 0;
    
    for (final entry in _entries) {
      _totalTreasures += entry.value;
      for (final type in entry.types) {
        _treasureTypeStatistics[type] = (_treasureTypeStatistics[type] ?? 0) + 1;
      }
    }
    
    // Calculate level based on total treasures
    _currentLevel = (_totalTreasures / AppConstants.treasuresPerLevel).floor() + 1;
    if (_currentLevel > AppConstants.maxLevel) {
      _currentLevel = AppConstants.maxLevel;
    }
  }

  // Update streak
  void _updateStreak() {
    if (_entries.isEmpty) {
      _currentStreak = 0;
      return;
    }

    // Sort entries by date (newest first)
    final sortedEntries = List<TreasureEntry>.from(_entries);
    sortedEntries.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    _currentStreak = 0;
    final today = DateTime.now();
    DateTime currentDate = DateTime(today.year, today.month, today.day);

    for (final entry in sortedEntries) {
      final entryDate = DateTime(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day);
      
      if (entryDate.isAtSameMomentAs(currentDate)) {
        _currentStreak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else if (entryDate.isBefore(currentDate)) {
        break;
      }
    }
  }

  // Check for new achievements
  Future<void> _checkAchievements() async {
    final newAchievements = await _achievementService.checkAchievements(
      totalEntries: _entries.length,
      currentStreak: _currentStreak,
      tagStatistics: _treasureTypeStatistics.map((key, value) => MapEntry(key.name, value)),
      totalXp: _totalTreasures,
    );
    
    if (newAchievements.isNotEmpty) {
      _newAchievements.addAll(newAchievements);
      notifyListeners();
    }
  }

  // Clear new achievements
  void clearNewAchievements() {
    _newAchievements.clear();
    notifyListeners();
  }

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _animationsEnabled = prefs.getBool(AppConstants.keyAnimationsEnabled) ?? true;
    _currentStreak = prefs.getInt(AppConstants.keyStreakCount) ?? 0;
    _totalTreasures = prefs.getInt(AppConstants.keyTotalTreasures) ?? 0;
    _currentLevel = prefs.getInt(AppConstants.keyCurrentLevel) ?? 1;
  }

  // Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyAnimationsEnabled, _animationsEnabled);
    await prefs.setInt(AppConstants.keyStreakCount, _currentStreak);
    await prefs.setInt(AppConstants.keyTotalTreasures, _totalTreasures);
    await prefs.setInt(AppConstants.keyCurrentLevel, _currentLevel);
  }

  // Toggle animations
  Future<void> toggleAnimations() async {
    _animationsEnabled = !_animationsEnabled;
    await _saveSettings();
    notifyListeners();
  }

  // Export entries to JSON
  Future<String> exportEntries() async {
    final entriesJson = _entries.map((e) => e.toJson()).toList();
    return '{"entries": $entriesJson, "exportedAt": "${DateTime.now().toIso8601String()}"}';
  }

  // Get level progress
  double getLevelProgress() {
    final currentLevelTreasures = (_currentLevel - 1) * AppConstants.treasuresPerLevel;
    final nextLevelTreasures = _currentLevel * AppConstants.treasuresPerLevel;
    final progress = _totalTreasures - currentLevelTreasures;
    final total = nextLevelTreasures - currentLevelTreasures;
    
    if (total == 0) return 1.0;
    return (progress / total).clamp(0.0, 1.0);
  }

  // Get treasures needed for next level
  int getTreasuresNeededForNextLevel() {
    final currentLevelTreasures = (_currentLevel - 1) * AppConstants.treasuresPerLevel;
    final nextLevelTreasures = _currentLevel * AppConstants.treasuresPerLevel;
    final needed = nextLevelTreasures - _totalTreasures;
    return needed > 0 ? needed : 0;
  }
}

