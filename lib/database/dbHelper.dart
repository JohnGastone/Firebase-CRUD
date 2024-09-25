// ignore_for_file: unnecessary_null_comparison

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlitecrud/model/dish.dart';

class Dbhelper {
  Database? _db; // Nullable to avoid initialization error

  Future<Database> initDb() async {
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
        description TEXT,
        price DOUBLE NOT NULL
      );
      ''',
    );
  }

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!; // Safely return the non-nullable _db
  }

  // Create Data method
  Future<int> createDish(Dish dish) async {
    var dbReady = await db; // Ensure db is ready
    return await dbReady.rawInsert(
        "INSERT INTO Dishes(name, description, price) VALUES('${dish.name}', '${dish.description}', '${dish.price}')");
  }

  // Update Data Method
  Future<int> updateDish(Dish dish) async {
    var dbReady = await db; // Ensure db is ready
    return await dbReady.rawUpdate(
        "UPDATE Dishes SET description='${dish.description}', price='${dish.price}' WHERE name='${dish.name}'");
  }

  // Delete Data Method
  Future<int> deleteDish(String name) async {
    var dbReady = await db; // Ensure db is ready
    return await dbReady.rawDelete("DELETE FROM Dishes WHERE name='$name'");
  }

  // Read Single Entry
  Future<Dish> readDish(String name) async {
    var dbReady = await db; // Ensure db is ready
    var result =
        await dbReady.rawQuery("SELECT * FROM Dishes WHERE name='$name'");
    if (result.isNotEmpty) {
      return Dish.fromMap(
          result.first); // Return the first entry matching the name
    } else {
      throw Exception("Dish not found");
    }
  }

  // Read All Entries
  Future<List<Dish>> readDishList() async {
    var dbReady = await db; // Ensure db is ready
    var result = await dbReady.rawQuery("SELECT * FROM Dishes");
    return result
        .map((data) => Dish.fromMap(data))
        .toList(); // Convert to List<Dish>
  }
}
