import 'package:minitalk/res/tables.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = "${await getDatabasesPath()}/mini-talk.db";
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE ${Tables.friend} (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      job TEXT NOT NULL,
      personality TEXT NOT NULL
    );
    ''');
  }

  Future<List<Map<String, Object?>>> find(String table, {String? where, List<Object?>? whereArgs}) async {
    return (await database).database.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    return (await database).database.insert(table, values);
  }

  Future<int> update(String table, Map<String, Object?> values) async {
    return (await database).database.update(
      table,
      values,
      where: "id = ?",
      whereArgs: [values["id"]],
    );
  }

  Future<int> delete(String table, Map<String, Object?> values) async {
    return (await database).database.delete(
      table,
      where: "id = ?",
      whereArgs: [values["id"]],
    );
  }
}
