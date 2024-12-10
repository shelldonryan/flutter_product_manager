import 'dart:convert';

class Product {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String? userId;

  Product(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.price,
      this.userId});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        quantity: map['quantity'] ?? 0,
        price: map['price'] ?? 0.00,
        userId: map['userId'] ?? '');
  }

  factory Product.fromJson(String jsonString) =>
      Product.fromMap(json.decode(jsonString));

  Map<String, dynamic> toMap() => {
     'id': id,
     'name': name,
     'quantity': quantity,
     'price': price,
     'userId': userId,
  };

  String toJson() => json.encode(toMap());
}
