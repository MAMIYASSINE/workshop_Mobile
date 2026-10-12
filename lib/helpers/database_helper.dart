import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workshop_flutter__4ei3/models/Film.dart';

abstract class FilmStorage {
  Future<List<Film>> getCartFilms();
  Future<void> addFilmToCart(Film film);
  Future<void> removeFilmFromCart(Film film);
  Future<void> clearCart();
  Future<List<Film>> getFavoriteFilms();
  Future<void> addFavorite(Film film);
  Future<void> removeFavorite(Film film);
}

class DatabaseHelper implements FilmStorage {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static const String _databaseName = 'gstore.db';
  static const int _databaseVersion = 1;
  static const String cartTable = 'cart_items';
  static const String favoritesTable = 'favorite_films';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDatabase,
    );
    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cartTable (
        title TEXT PRIMARY KEY,
        image TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $favoritesTable (
        title TEXT PRIMARY KEY,
        image TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');
  }

  @override
  Future<List<Film>> getCartFilms() async {
    final db = await database;
    final maps = await db.query(cartTable, orderBy: 'title');
    return maps.map(Film.fromMap).toList();
  }

  @override
  Future<void> addFilmToCart(Film film) async {
    final db = await database;
    await db.insert(
      cartTable,
      film.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFilmFromCart(Film film) async {
    final db = await database;
    await db.delete(cartTable, where: 'title = ?', whereArgs: [film.title]);
  }

  @override
  Future<void> clearCart() async {
    final db = await database;
    await db.delete(cartTable);
  }

  @override
  Future<List<Film>> getFavoriteFilms() async {
    final db = await database;
    final maps = await db.query(favoritesTable, orderBy: 'title');
    return maps.map(Film.fromMap).toList();
  }

  @override
  Future<void> addFavorite(Film film) async {
    final db = await database;
    await db.insert(
      favoritesTable,
      film.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite(Film film) async {
    final db = await database;
    await db.delete(
      favoritesTable,
      where: 'title = ?',
      whereArgs: [film.title],
    );
  }
}
