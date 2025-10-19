import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

enum AchievementType {
  @JsonValue('streak')
  streak,
  @JsonValue('count')
  count,
  @JsonValue('treasure_type')
  treasureType,
  @JsonValue('level')
  level,
  @JsonValue('special')
  special,
}

enum AchievementRarity {
  @JsonValue('common')
  common,
  @JsonValue('rare')
  rare,
  @JsonValue('epic')
  epic,
  @JsonValue('legendary')
  legendary,
}

@JsonSerializable()
class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final AchievementType type;
  final AchievementRarity rarity;
  final int targetValue;
  final String? treasureType; // For treasure-type-specific achievements
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int currentProgress;
  final int xpReward;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    required this.rarity,
    required this.targetValue,
    this.treasureType,
    this.isUnlocked = false,
    this.unlockedAt,
    this.currentProgress = 0,
    this.xpReward = 0,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  Map<String, dynamic> toJson() => _$AchievementToJson(this);

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    AchievementType? type,
    AchievementRarity? rarity,
    int? targetValue,
    String? treasureType,
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? currentProgress,
    int? xpReward,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      rarity: rarity ?? this.rarity,
      targetValue: targetValue ?? this.targetValue,
      treasureType: treasureType ?? this.treasureType,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      currentProgress: currentProgress ?? this.currentProgress,
      xpReward: xpReward ?? this.xpReward,
    );
  }

  double get progressPercentage {
    if (targetValue == 0) return 0.0;
    return (currentProgress / targetValue).clamp(0.0, 1.0);
  }

  bool get isCompleted => currentProgress >= targetValue;
}

@JsonSerializable()
class UserLevel {
  final int level;
  final int currentXp;
  final int xpToNextLevel;
  final int totalXp;

  const UserLevel({
    required this.level,
    required this.currentXp,
    required this.xpToNextLevel,
    required this.totalXp,
  });

  factory UserLevel.fromJson(Map<String, dynamic> json) =>
      _$UserLevelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLevelToJson(this);

  UserLevel copyWith({
    int? level,
    int? currentXp,
    int? xpToNextLevel,
    int? totalXp,
  }) {
    return UserLevel(
      level: level ?? this.level,
      currentXp: currentXp ?? this.currentXp,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      totalXp: totalXp ?? this.totalXp,
    );
  }

  double get progressPercentage {
    if (xpToNextLevel == 0) return 1.0;
    return (currentXp / xpToNextLevel).clamp(0.0, 1.0);
  }
}

