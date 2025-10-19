import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/achievement.dart';
import '../models/treasure_entry.dart';
import '../constants/achievements.dart';

class AchievementService {
  static final AchievementService _instance = AchievementService._internal();
  factory AchievementService() => _instance;
  AchievementService._internal();

  List<Achievement> _achievements = [];
  UserLevel _userLevel = const UserLevel(
    level: 1,
    currentXp: 0,
    xpToNextLevel: 100,
    totalXp: 0,
  );
  final StreamController<List<Achievement>> _achievementsController =
      StreamController<List<Achievement>>.broadcast();
  final StreamController<UserLevel> _userLevelController =
      StreamController<UserLevel>.broadcast();
  final StreamController<Achievement> _newAchievementController =
      StreamController<Achievement>.broadcast();

  // Getters
  List<Achievement> get achievements => _achievements;
  UserLevel get userLevel => _userLevel;
  Stream<List<Achievement>> get achievementsStream =>
      _achievementsController.stream;
  Stream<UserLevel> get userLevelStream => _userLevelController.stream;
  Stream<Achievement> get newAchievementStream =>
      _newAchievementController.stream;

  // Initialize the service
  Future<void> initialize() async {
    await _loadAchievements();
    await _loadUserLevel();
  }

  // Load achievements from SharedPreferences
  Future<void> _loadAchievements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final achievementsJson = prefs.getString('achievements') ?? '[]';
      final List<dynamic> achievementsList = json.decode(achievementsJson);

      if (achievementsList.isEmpty) {
        // Initialize with predefined achievements
        _achievements = List.from(AchievementConstants.predefinedAchievements);
        await _saveAchievements();
      } else {
        _achievements = achievementsList
            .map((json) => Achievement.fromJson(json))
            .toList();
      }

      _achievementsController.add(_achievements);
    } catch (e) {
      debugPrint('Error loading achievements: $e');
      _achievements = List.from(AchievementConstants.predefinedAchievements);
      await _saveAchievements();
    }
  }

  // Save achievements to SharedPreferences
  Future<void> _saveAchievements() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final achievementsJson = json.encode(
        _achievements.map((a) => a.toJson()).toList(),
      );
      await prefs.setString('achievements', achievementsJson);
    } catch (e) {
      debugPrint('Error saving achievements: $e');
    }
  }

  // Load user level from SharedPreferences
  Future<void> _loadUserLevel() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final totalXp = prefs.getInt('total_xp') ?? 0;
      _userLevel = AchievementConstants.calculateUserLevel(totalXp);
      _userLevelController.add(_userLevel);
    } catch (e) {
      debugPrint('Error loading user level: $e');
      _userLevel = const UserLevel(
        level: 1,
        currentXp: 0,
        xpToNextLevel: 100,
        totalXp: 0,
      );
    }
  }

  // Save user level to SharedPreferences
  Future<void> _saveUserLevel() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('total_xp', _userLevel.totalXp);
    } catch (e) {
      debugPrint('Error saving user level: $e');
    }
  }

  // Check achievements and return newly unlocked ones
  Future<List<Achievement>> checkAchievements({
    required int totalEntries,
    required int currentStreak,
    required Map<String, int> tagStatistics,
    required int totalXp,
  }) async {
    List<Achievement> newAchievements = [];
    bool hasChanges = false;

    for (int i = 0; i < _achievements.length; i++) {
      final achievement = _achievements[i];
      if (achievement.isUnlocked) continue;

      bool shouldUnlock = false;
      int newProgress = 0;

      switch (achievement.type) {
        case AchievementType.count:
          newProgress = totalEntries;
          shouldUnlock = newProgress >= achievement.targetValue;
          break;
        case AchievementType.streak:
          newProgress = currentStreak;
          shouldUnlock = newProgress >= achievement.targetValue;
          break;
        case AchievementType.treasureType:
          if (achievement.treasureType != null) {
            newProgress = tagStatistics[achievement.treasureType!] ?? 0;
            shouldUnlock = newProgress >= achievement.targetValue;
          }
          break;
        case AchievementType.level:
          final userLevel = AchievementConstants.calculateUserLevel(totalXp);
          newProgress = userLevel.level;
          shouldUnlock = newProgress >= achievement.targetValue;
          break;
        case AchievementType.special:
          // Special achievements are handled separately
          break;
      }

      if (newProgress != achievement.currentProgress) {
        _achievements[i] = achievement.copyWith(currentProgress: newProgress);
        hasChanges = true;
      }

      if (shouldUnlock && !achievement.isUnlocked) {
        _achievements[i] = achievement.copyWith(
          isUnlocked: true,
          unlockedAt: DateTime.now(),
          currentProgress: newProgress,
        );
        newAchievements.add(_achievements[i]);
        hasChanges = true;
      }
    }

    if (hasChanges) {
      await _saveAchievements();
      _achievementsController.add(_achievements);
    }

    // Update user level
    final newUserLevel = AchievementConstants.calculateUserLevel(totalXp);
    if (newUserLevel.level != _userLevel.level) {
      _userLevel = newUserLevel;
      await _saveUserLevel();
      _userLevelController.add(_userLevel);
    }

    // Notify about new achievements
    for (final achievement in newAchievements) {
      _newAchievementController.add(achievement);
    }

    return newAchievements;
  }

  // Get achievements by type
  List<Achievement> getAchievementsByType(AchievementType type) {
    return _achievements.where((a) => a.type == type).toList();
  }

  // Get achievements by rarity
  List<Achievement> getAchievementsByRarity(AchievementRarity rarity) {
    return _achievements.where((a) => a.rarity == rarity).toList();
  }

  // Get unlocked achievements
  List<Achievement> getUnlockedAchievements() {
    return _achievements.where((a) => a.isUnlocked).toList();
  }

  // Get locked achievements
  List<Achievement> getLockedAchievements() {
    return _achievements.where((a) => !a.isUnlocked).toList();
  }

  // Get achievement by ID
  Achievement? getAchievementById(String id) {
    try {
      return _achievements.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get total XP from achievements
  int getTotalXpFromAchievements() {
    return _achievements
        .where((a) => a.isUnlocked)
        .fold(0, (sum, a) => sum + a.xpReward);
  }

  // Get completion percentage
  double getCompletionPercentage() {
    if (_achievements.isEmpty) return 0.0;
    final unlockedCount = _achievements.where((a) => a.isUnlocked).length;
    return unlockedCount / _achievements.length;
  }

  // Get achievements by progress
  List<Achievement> getAchievementsInProgress() {
    return _achievements.where((a) => 
      !a.isUnlocked && a.currentProgress > 0
    ).toList();
  }

  // Reset all achievements (for testing)
  Future<void> resetAchievements() async {
    _achievements = List.from(AchievementConstants.predefinedAchievements);
    await _saveAchievements();
    _achievementsController.add(_achievements);
  }

  // Dispose
  void dispose() {
    _achievementsController.close();
    _userLevelController.close();
    _newAchievementController.close();
  }
}

