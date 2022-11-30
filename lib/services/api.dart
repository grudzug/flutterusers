import 'dart:convert';
import 'package:mygetxapp/models/user_model.dart';
import 'package:http/http.dart' as http;

class Api {
  final String url;
  Api({required this.url});

  static final client = http.Client();

  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  String getErrorMessageFromServer(response) {
    if (response.statusCode == 400) {
      return 'Bad request';
    }
    if (response.statusCode == 401) {
      return 'Unauthorized';
    }
    if (response.statusCode == 403) {
      return 'Forbidden';
    }
    if (response.statusCode == 404) {
      return 'Not found';
    }
    if (response.statusCode == 500) {
      return 'Internal server error';
    }
    if (response.statusCode == 503) {
      return 'Service unavailable';
    }
    List errorMessages = [];
    jsonDecode(response.body).forEach((key, value) {
      errorMessages.add('$key: ${value.join(', ')}');
    });
    String errorMessage = errorMessages.join(', ');
    return errorMessage;
  }

  Future<List<User>?> getUsers() async {
    final response = await client.get(Uri.parse(url), headers: headers);

    if (response.statusCode ~/ 100 != 2) {
      return Future.error(
          'Something went wrong: ${getErrorMessageFromServer(response)}');
    }
    final users = userFromJson(response.body);
    users.sort((User a, User b) => b.createdAt.compareTo(a.createdAt));
    return users;
  }

  Future updateStatus(int id, String status) async {
    final response = await client.put(Uri.parse('$url/$id'),
        headers: headers,
        body: jsonEncode(<String, String>{
          'status': status,
        }));
    if (response.statusCode ~/ 100 != 2) {
      return Future.error(
          'Failed updating user status: ${getErrorMessageFromServer(response)}');
    }
  }

  Future editUser(int id, String firstName, String lastName) async {
    final response = await client.put(Uri.parse('$url/$id'),
        headers: headers,
        body: jsonEncode(<String, String>{
          'first_name': firstName,
          'last_name': lastName,
        }));
    if (response.statusCode ~/ 100 != 2) {
      return Future.error(
          'Failed updating user: ${getErrorMessageFromServer(response)}');
    }
  }

  Future deleteUser(int id) async {
    final response =
        await client.delete(Uri.parse('$url/$id'), headers: headers);
    if (response.statusCode ~/ 100 != 2) {
      return Future.error(
          'Failed deleting user: ${getErrorMessageFromServer(response)}');
    }
  }

  Future addUser(String firstName, String lastName) async {
    final response = await client.post(Uri.parse(url),
        headers: headers,
        body: jsonEncode(<String, String>{
          'first_name': firstName,
          'last_name': lastName,
          'status': 'active',
        }));
    if (response.statusCode ~/ 100 != 2) {
      return Future.error(
          'Failed creating new user: ${getErrorMessageFromServer(response)}');
    }
  }
}
