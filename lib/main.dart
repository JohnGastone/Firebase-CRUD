// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqlitecrud/database/dbHelper.dart';
import 'package:sqlitecrud/model/dish.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.dark, primaryColor: Colors.lightBlue[600]),
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String name, description;
  late double price;

  void getName(String name) {
    setState(() {
      this.name = name;
      if (kDebugMode) {
        print(this.name);
      }
    });
  }

  void getDescription(String description) {
    setState(() {
      this.description = description;
      if (kDebugMode) {
        print(this.description);
      }
    });
  }

  void getPrice(String price) {
    setState(() {
      this.price = double.tryParse(price) ?? 0.0;
      if (kDebugMode) {
        print(this.price);
      }
    });
  }

  createData() {
    var dbHelper = Dbhelper();
    var dish = Dish(name: name, description: description, price: price);
    dbHelper.createDish(dish);
  }

  updateData() {
    var dbHelper = Dbhelper();
    var dish = Dish(name: name, description: description, price: price);
    dbHelper.updateDish(dish);
  }

  Future<void> readData(String name) async {
    var dbHelper = Dbhelper();
    try {
      Dish dish = await dbHelper.readDish(name); // Use readDish(name)
      print("${dish.name}, ${dish.description}, ${dish.price}");
    } catch (error) {
      print("Error reading dish data: $error"); // Handle error (optional)
    }
  }

  Future<List<Dish>> readDishList() async {
    var dbHelper = Dbhelper();
    try {
      List<Dish> dishes = await dbHelper.readDishList(); // Use readDataList()
      print(dishes);
      return dishes; // Add return statement
    } catch (error) {
      print("Error reading dish data: $error"); // Handle error (optional)
      return []; // Add return statement for non-nullable type
    }
  }

  deleteData() {
    var dbHelper = Dbhelper();
    dbHelper.deleteDish(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: 'Name'),
            onChanged: (String name) {
              getName(name);
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Description'),
            onChanged: (String description) {
              getDescription(description);
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Price'),
            onChanged: (String price) {
              getPrice(price);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              SizedBox(
                height: 35,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    createData();
                  },
                  child: Text("Create"),
                ),
              ),
              SizedBox(
                height: 35,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    readData(name);
                  },
                  child: Text("Read"),
                ),
              ),
              SizedBox(
                height: 35,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.purple,
                  onPressed: () {
                    updateData();
                  },
                  child: Text("Update"),
                ),
              ),
              SizedBox(
                height: 35,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    deleteData();
                  },
                  child: Text("Delete"),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Name")),
                Expanded(child: Text("Description")),
                Expanded(child: Text("Price"))
              ],
            ),
          ),
          FutureBuilder<List<Dish>>(
              future: readDishList(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (snapshot.data!.isEmpty) {
                      return Text("No dishes found.");
                    }
                    return ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].description),
                      trailing: Text(snapshot.data![index].price.toString()),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              })
        ],
      ),
    );
  }
}
