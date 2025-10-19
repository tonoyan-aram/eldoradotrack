import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/treasure_entry.dart';
import '../constants/app_constants.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConstants.databaseName);
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.entriesTableName}(
        id TEXT PRIMARY KEY,
        text TEXT NOT NULL,
        types TEXT NOT NULL,
        value INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  Future<String> insertTreasureEntry(TreasureEntry entry) async {
    final db = await database;
    await db.insert(
      AppConstants.entriesTableName,
      _treasureEntryToMap(entry),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return entry.id;
  }

  Future<List<TreasureEntry>> getAllTreasureEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return _mapToTreasureEntry(maps[i]);
    });
  }

  Future<TreasureEntry?> getTreasureEntryById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return _mapToTreasureEntry(maps.first);
    }
    return null;
  }

  Future<void> updateTreasureEntry(TreasureEntry entry) async {
    final db = await database;
    await db.update(
      AppConstants.entriesTableName,
      _treasureEntryToMap(entry),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<void> deleteTreasureEntry(String id) async {
    final db = await database;
    await db.delete(
      AppConstants.entriesTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TreasureEntry>> getTreasureEntriesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      where: 'created_at BETWEEN ? AND ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return _mapToTreasureEntry(maps[i]);
    });
  }

  Future<List<TreasureEntry>> getTreasureEntriesByType(TreasureType type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      where: 'types LIKE ?',
      whereArgs: ['%${type.name}%'],
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return _mapToTreasureEntry(maps[i]);
    });
  }

  Future<int> getTreasureEntryCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM ${AppConstants.entriesTableName}');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> getTotalTreasureValue() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(value) as total FROM ${AppConstants.entriesTableName}');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<Map<TreasureType, int>> getTreasureTypeStatistics() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.entriesTableName,
      columns: ['types'],
    );

    Map<TreasureType, int> statistics = {};
    for (final map in maps) {
      final typesString = map['types'] as String;
      final types = typesString.split(',').map((t) => TreasureType.values.firstWhere(
        (e) => e.name == t.trim(),
        orElse: () => TreasureType.other,
      )).toList();

      for (final type in types) {
        statistics[type] = (statistics[type] ?? 0) + 1;
      }
    }

    return statistics;
  }

  Future<void> deleteOldDatabase() async {
    try {
      final databasesPath = await getDatabasesPath();
      final dbPath = join(databasesPath, AppConstants.databaseName);
      await databaseFactory.deleteDatabase(dbPath);
    } catch (e) {
      // Database might not exist, which is fine
    }
  }

  Map<String, dynamic> _treasureEntryToMap(TreasureEntry entry) {
    return {
      'id': entry.id,
      'text': entry.text,
      'types': entry.types.map((t) => t.name).join(','),
      'value': entry.value,
      'created_at': entry.createdAt.millisecondsSinceEpoch,
      'updated_at': entry.updatedAt.millisecondsSinceEpoch,
    };
  }

  TreasureEntry _mapToTreasureEntry(Map<String, dynamic> map) {
    final typesString = map['types'] as String;
    final types = typesString.split(',').map((t) => TreasureType.values.firstWhere(
      (e) => e.name == t.trim(),
      orElse: () => TreasureType.other,
    )).toList();

    return TreasureEntry(
      id: map['id'],
      text: map['text'],
      types: types,
      value: map['value'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}

