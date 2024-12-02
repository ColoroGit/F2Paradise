import 'package:f2paradise/models/game.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'games.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE games(
        id INTEGER PRIMARY KEY,
        title TEXT,
        thumbnail TEXT,
        short_description TEXT,
        game_url TEXT,
        genre TEXT,
        platform TEXT,
        publisher TEXT,
        developer TEXT,
        release_date TEXT,
        like INTEGER,
        played INTEGER,
        timestamp INTEGER
      )
    ''');
  }

  Future<int> insertGame(Game game) async {
    Database db = await database;
    return await db.insert('games', game.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Game?> getGameById(int id) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'games',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Game.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Game>> getAllGames() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'games',
      orderBy: 'title ASC',
    );
    return List.generate(maps.length, (i) {
      return Game.fromJson(maps[i]);
    });
  }

  // Future<int> updateGame(Game game) async {
  //   Database db = await database;
  //   return await db.update(
  //     'games',
  //     game.toJson(),
  //     where: 'id = ?',
  //     whereArgs: [game.id],
  //   );
  // }

  Future<int> deleteGame(int id) async {
    Database db = await database;
    return await db.delete(
      'games',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Game>> getRecentGames() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'games',
      orderBy: 'timestamp DESC',
      limit: 5,
    );
    return List.generate(maps.length, (i) {
      return Game.fromJson(maps[i]);
    });
  }

  Future<String> getMostFrequentGenre() async {
    Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT genre, COUNT(genre) as count
      FROM games
      GROUP BY genre
      ORDER BY count DESC
      LIMIT 1
    ''');
    return result.isNotEmpty ? result.first['genre'] as String : '';
  }
}
