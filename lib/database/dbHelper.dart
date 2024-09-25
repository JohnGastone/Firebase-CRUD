import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  initDb() async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, 'CRUDdb.db');

    var db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS users (
        name INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        price TEXT UNIQUE NOT NULL
      );
      ''',
    );
  }
}
