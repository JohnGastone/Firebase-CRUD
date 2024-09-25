class Dish {
  late String name, description;
  late double price;
  Dish({required this.name, required this.description, required this.price});

  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
      name: map['name'],
      description: map['description'],
      price: map['price'] as double,
    );
  }
}
