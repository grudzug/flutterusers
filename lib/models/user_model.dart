import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((data) => User.fromJson(data)));

class User {
  User({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  final int id;
  String lastName;
  String firstName;
  String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String url;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        lastName: json["last_name"],
        firstName: json["first_name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
      );
}
