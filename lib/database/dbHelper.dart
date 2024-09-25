// ignore_for_file: unnecessary_null_comparison

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  late Database _db;

  initDb() async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'CRUDdb.db');

    var db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS Dishes (
        name TEXT NOT NULL,
        description TEXT ,
        price DOUBLE UNIQUE NOT NULL
      );
      ''',
    );
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }
}
