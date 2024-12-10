import 'dart:convert';

class User {
  final String id;
  final String username;
  final String password;
  final String type;

  User({required this.id, required this.password, required this.username, required this.type});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], username: map['username'], password: map['password'], type: map['type']);
  }

  factory User.fromJson(String jsonString) => User.fromMap(json.decode(jsonString));

  Map<String, dynamic> toMap() => {
    'id': id,
    'username': username,
    'password': password,
    'type': type,
  };

  String toJson() => json.encode(toMap());
}