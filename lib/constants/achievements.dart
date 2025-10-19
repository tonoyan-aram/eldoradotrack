import '../models/achievement.dart';

class AchievementConstants {
  // XP required for each level (total XP, not XP to next level)
  static const List<int> levelXpRequirements = [
    0,      // Level 1
    100,    // Level 2
    250,    // Level 3
    500,    // Level 4
    1000,   // Level 5
    2000,   // Level 6
    3500,   // Level 7
    5500,   // Level 8
    8000,   // Level 9
    12000,  // Level 10
    17000,  // Level 11
    23000,  // Level 12
    30000,  // Level 13
    38000,  // Level 14
    47000,  // Level 15
    57000,  // Level 16
    68000,  // Level 17
    80000,  // Level 18
    93000,  // Level 19
    107000, // Level 20
  ];

  // Predefined achievements
  static const List<Achievement> predefinedAchievements = [
    // First treasure achievements
    Achievement(
      id: 'first_treasure',
      title: 'First Treasure',
      description: 'Record your first treasure',
      icon: '🏆',
      type: AchievementType.count,
      rarity: AchievementRarity.common,
      targetValue: 1,
      xpReward: 10,
    ),
    Achievement(
      id: 'treasure_hunter',
      title: 'Treasure Hunter',
      description: 'Record 10 treasures',
      icon: '🗺️',
      type: AchievementType.count,
      rarity: AchievementRarity.common,
      targetValue: 10,
      xpReward: 25,
    ),
    Achievement(
      id: 'gold_digger',
      title: 'Gold Digger',
      description: 'Record 50 treasures',
      icon: '⛏️',
      type: AchievementType.count,
      rarity: AchievementRarity.rare,
      targetValue: 50,
      xpReward: 75,
    ),
    Achievement(
      id: 'treasure_master',
      title: 'Treasure Master',
      description: 'Record 100 treasures',
      icon: '👑',
      type: AchievementType.count,
      rarity: AchievementRarity.epic,
      targetValue: 100,
      xpReward: 200,
    ),
    Achievement(
      id: 'el_dorado_legend',
      title: 'El Dorado Legend',
      description: 'Record 500 treasures',
      icon: '🏛️',
      type: AchievementType.count,
      rarity: AchievementRarity.legendary,
      targetValue: 500,
      xpReward: 750,
    ),

    // Streak achievements
    Achievement(
      id: 'daily_hunter',
      title: 'Daily Hunter',
      description: 'Record treasures for 3 days in a row',
      icon: '🔥',
      type: AchievementType.streak,
      rarity: AchievementRarity.common,
      targetValue: 3,
      xpReward: 30,
    ),
    Achievement(
      id: 'week_warrior',
      title: 'Week Warrior',
      description: 'Record treasures for 7 days in a row',
      icon: '⚡',
      type: AchievementType.streak,
      rarity: AchievementRarity.rare,
      targetValue: 7,
      xpReward: 75,
    ),
    Achievement(
      id: 'monthly_master',
      title: 'Monthly Master',
      description: 'Record treasures for 30 days in a row',
      icon: '🏆',
      type: AchievementType.streak,
      rarity: AchievementRarity.epic,
      targetValue: 30,
      xpReward: 200,
    ),
    Achievement(
      id: 'century_champion',
      title: 'Century Champion',
      description: 'Record treasures for 100 days in a row',
      icon: '💎',
      type: AchievementType.streak,
      rarity: AchievementRarity.legendary,
      targetValue: 100,
      xpReward: 500,
    ),

    // Treasure type achievements
    Achievement(
      id: 'gold_collector',
      title: 'Gold Collector',
      description: 'Record 10 gold treasures',
      icon: '🥇',
      type: AchievementType.treasureType,
      rarity: AchievementRarity.common,
      targetValue: 10,
      treasureType: 'gold',
      xpReward: 40,
    ),
    Achievement(
      id: 'jewelry_expert',
      title: 'Jewelry Expert',
      description: 'Record 10 jewelry treasures',
      icon: '💍',
      type: AchievementType.treasureType,
      rarity: AchievementRarity.common,
      targetValue: 10,
      treasureType: 'jewelry',
      xpReward: 40,
    ),
    Achievement(
      id: 'artifact_archaeologist',
      title: 'Artifact Archaeologist',
      description: 'Record 10 artifact treasures',
      icon: '🏺',
      type: AchievementType.treasureType,
      rarity: AchievementRarity.common,
      targetValue: 10,
      treasureType: 'artifacts',
      xpReward: 40,
    ),
    Achievement(
      id: 'coin_collector',
      title: 'Coin Collector',
      description: 'Record 10 coin treasures',
      icon: '🪙',
      type: AchievementType.treasureType,
      rarity: AchievementRarity.common,
      targetValue: 10,
      treasureType: 'coins',
      xpReward: 40,
    ),
    Achievement(
      id: 'gem_hunter',
      title: 'Gem Hunter',
      description: 'Record 10 gem treasures',
      icon: '💎',
      type: AchievementType.treasureType,
      rarity: AchievementRarity.common,
      targetValue: 10,
      treasureType: 'gems',
      xpReward: 40,
    ),

    // Level achievements
    Achievement(
      id: 'level_5',
      title: 'Apprentice Explorer',
      description: 'Reach level 5',
      icon: '🗺️',
      type: AchievementType.level,
      rarity: AchievementRarity.common,
      targetValue: 5,
      xpReward: 50,
    ),
    Achievement(
      id: 'level_10',
      title: 'Seasoned Adventurer',
      description: 'Reach level 10',
      icon: '⚔️',
      type: AchievementType.level,
      rarity: AchievementRarity.rare,
      targetValue: 10,
      xpReward: 100,
    ),
    Achievement(
      id: 'level_15',
      title: 'Master Treasure Hunter',
      description: 'Reach level 15',
      icon: '🏰',
      type: AchievementType.level,
      rarity: AchievementRarity.epic,
      targetValue: 15,
      xpReward: 200,
    ),
    Achievement(
      id: 'level_20',
      title: 'El Dorado Legend',
      description: 'Reach level 20',
      icon: '👑',
      type: AchievementType.level,
      rarity: AchievementRarity.legendary,
      targetValue: 20,
      xpReward: 500,
    ),

    // Special achievements
    Achievement(
      id: 'all_treasure_types',
      title: 'Universal Collector',
      description: 'Record treasures of all 6 types',
      icon: '🌈',
      type: AchievementType.special,
      rarity: AchievementRarity.rare,
      targetValue: 6,
      xpReward: 150,
    ),
    Achievement(
      id: 'valuable_treasure',
      title: 'Valuable Discovery',
      description: 'Record a treasure with high value (50+)',
      icon: '💰',
      type: AchievementType.special,
      rarity: AchievementRarity.common,
      targetValue: 1,
      xpReward: 25,
    ),
    Achievement(
      id: 'early_explorer',
      title: 'Early Explorer',
      description: 'Record a treasure before 8 AM',
      icon: '🌅',
      type: AchievementType.special,
      rarity: AchievementRarity.rare,
      targetValue: 1,
      xpReward: 50,
    ),
    Achievement(
      id: 'night_owl_hunter',
      title: 'Night Owl Hunter',
      description: 'Record a treasure after 10 PM',
      icon: '🦉',
      type: AchievementType.special,
      rarity: AchievementRarity.rare,
      targetValue: 1,
      xpReward: 50,
    ),
    Achievement(
      id: 'treasure_hoard',
      title: 'Treasure Hoard',
      description: 'Record 5 treasures in a single day',
      icon: '📦',
      type: AchievementType.special,
      rarity: AchievementRarity.epic,
      targetValue: 1,
      xpReward: 100,
    ),
  ];

  // Level names for El Dorado theme
  static const List<String> levelNames = [
    'Treasure Seeker',        // Level 1
    'Gold Digger',           // Level 2
    'Jewel Hunter',          // Level 3
    'Artifact Finder',       // Level 4
    'Coin Collector',        // Level 5
    'Gem Explorer',          // Level 6
    'Treasure Hunter',       // Level 7
    'Gold Prospector',       // Level 8
    'Jewel Master',          // Level 9
    'Artifact Expert',       // Level 10
    'Coin Connoisseur',      // Level 11
    'Gem Specialist',        // Level 12
    'Treasure Master',       // Level 13
    'Gold Baron',            // Level 14
    'Jewel Baron',           // Level 15
    'Artifact Baron',        // Level 16
    'Coin Baron',            // Level 17
    'Gem Baron',             // Level 18
    'Treasure Baron',        // Level 19
    'El Dorado Legend',      // Level 20
  ];

  static String getLevelName(int level) {
    if (level <= 0 || level > levelNames.length) {
      return 'Unknown Explorer';
    }
    return levelNames[level - 1];
  }

  static int getXpForLevel(int level) {
    if (level <= 0 || level > levelXpRequirements.length) {
      return 0;
    }
    return levelXpRequirements[level - 1];
  }

  static int getXpToNextLevel(int currentLevel, int currentXp) {
    if (currentLevel >= levelXpRequirements.length) {
      return 0; // Max level reached
    }
    final nextLevelXp = getXpForLevel(currentLevel + 1);
    return nextLevelXp - currentXp;
  }

  static UserLevel calculateUserLevel(int totalXp) {
    int level = 1;
    for (int i = 0; i < levelXpRequirements.length; i++) {
      if (totalXp >= levelXpRequirements[i]) {
        level = i + 1;
      } else {
        break;
      }
    }

    final currentLevelXp = getXpForLevel(level);
    final xpToNextLevel = getXpToNextLevel(level, totalXp);

    return UserLevel(
      level: level,
      currentXp: totalXp - currentLevelXp,
      xpToNextLevel: xpToNextLevel,
      totalXp: totalXp,
    );
  }
}

