import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
class AuthService {

  Future<String?> fetchUserEmail(String username) async {
    final response = await http.get(Uri.parse(usersUrl));

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      for (var user in users) {
        if (user['name'].toLowerCase() == username.toLowerCase()) {
          return user['email'];
        }
      }
    }
    return null;
  }

  Future<http.Response> login(String email, String password) {
    return http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
  }

  Future<http.Response> signUp(Map<String, dynamic> userData) {
    return http.post(
      Uri.parse(usersUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    );
  }

  Future<http.Response> checkEmailAvailability(String email) {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/users/is-available');

    return http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
  }
  Future<List<dynamic>> fetchAllUsers() async {
    final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/users'));

    if (response.statusCode == 200) {
      // Parse the response as a list of users
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
}
