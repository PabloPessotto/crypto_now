import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._internal();

  factory LocalDatabase() => instance;

  LocalDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final fullDatabasePath = join(databasePath, "crypto-now.db");
    var db = await openDatabase(
      fullDatabasePath,
      version: 1,
      onCreate: _onCreateDB,
      onUpgrade: _onUpgradeDB,
    );
    return db;
  }

  final String _tableUser = '''CREATE TABLE IF NOT EXISTS user(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email VARCHAR UNIQUE,
  password VARCHAR,
  startSession INTEGER
  );''';

  _onCreateDB(Database db, int version) async {
    await db.execute(_tableUser);
  }

  _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      //Script de atualização aqui
    }
  }

  Future<void> deleteDatabase(String path) => databaseFactory.deleteDatabase(path);

  Future<void> delete() async {
    final databasePath = await getDatabasesPath();
    final fullDatabasePath = join(databasePath, "crypto-now.db");

    deleteDatabase(fullDatabasePath);
  }
}
