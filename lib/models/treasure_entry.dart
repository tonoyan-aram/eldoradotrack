import 'package:json_annotation/json_annotation.dart';

part 'treasure_entry.g.dart';

enum TreasureType {
  @JsonValue('gold')
  gold,
  @JsonValue('jewelry')
  jewelry,
  @JsonValue('artifacts')
  artifacts,
  @JsonValue('coins')
  coins,
  @JsonValue('gems')
  gems,
  @JsonValue('other')
  other;

  String get displayName {
    switch (this) {
      case TreasureType.gold:
        return 'Gold';
      case TreasureType.jewelry:
        return 'Jewelry';
      case TreasureType.artifacts:
        return 'Artifacts';
      case TreasureType.coins:
        return 'Coins';
      case TreasureType.gems:
        return 'Gems';
      case TreasureType.other:
        return 'Other';
    }
  }

  String get emoji {
    switch (this) {
      case TreasureType.gold:
        return '🥇';
      case TreasureType.jewelry:
        return '💍';
      case TreasureType.artifacts:
        return '🏺';
      case TreasureType.coins:
        return '🪙';
      case TreasureType.gems:
        return '💎';
      case TreasureType.other:
        return '📦';
    }
  }
}

@JsonSerializable()
class TreasureEntry {
  final String id;
  final String text;
  final List<TreasureType> types;
  final int value; // Treasure value for leveling
  final DateTime createdAt;
  final DateTime updatedAt;

  const TreasureEntry({
    required this.id,
    required this.text,
    required this.types,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TreasureEntry.fromJson(Map<String, dynamic> json) =>
      _$TreasureEntryFromJson(json);

  Map<String, dynamic> toJson() => _$TreasureEntryToJson(this);

  TreasureEntry copyWith({
    String? id,
    String? text,
    List<TreasureType>? types,
    int? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TreasureEntry(
      id: id ?? this.id,
      text: text ?? this.text,
      types: types ?? this.types,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

