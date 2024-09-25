// ignore_for_file: unnecessary_null_comparison

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlitecrud/model/dish.dart';

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
        price DOUBLE  NOT NULL
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

  //Create Data method
  Future<int> createDish(Dish dish) async {
    var dbReady = await db;
    return await dbReady.rawInsert(
        "INSERT INTO Dishes(name, description, price) VALUES('${dish.name}', '${dish.description}', '${dish.price}') ");
  }

  // Update Data Method
  Future<int> updateDish(Dish dish) async {
    var dbReady = await db;
    return await dbReady.rawUpdate(
        "UPDATE Dishes SET name='${dish.name}', description='${dish.description}', price='${dish.price}' WHERE name=${dish.name}");
  }

  // Delete Data Method
  Future<int> deleteDish(String name) async {
    var dbReady = await db;
    return await dbReady.rawDelete("DELETE FROM Dishes WHERE name='$name'");
  }

  // Read Data Method
  Future<Dish> getAllDishes() async {
    var dbReady = await db;
    var read = await dbReady.rawQuery("SELECT * FROM Dishes");
    return Dish.fromMap(read[0]);
  }
}
