import 'dart:convert';

class Product {
  final String id;
  final String name;
  final int quantity;
  final double price;

  Product(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.price,});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        quantity: int.parse(map['quantity'].toString()),
        price: double.parse(map['price'].toString()));
  }

  factory Product.fromJson(String jsonString) =>
      Product.fromMap(json.decode(jsonString));

  Map<String, dynamic> toMap() => {
     'id': id,
     'name': name,
     'quantity': quantity,
     'price': price,
  };

  String toJson() => json.encode(toMap());
}
