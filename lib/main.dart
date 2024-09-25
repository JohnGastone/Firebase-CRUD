// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
                  onPressed: () {},
                  child: Text("Create"),
                ),
              ),
              SizedBox(
                height: 35,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.yellow,
                  onPressed: () {},
                  child: Text("Read"),
                ),
              ),
              SizedBox(
                height: 35,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.purple,
                  onPressed: () {},
                  child: Text("Update"),
                ),
              ),
              SizedBox(
                height: 35,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {},
                  child: Text("Delete"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
