import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth {
  static const _url = "http://localhost:3002/auth";
  static const _header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final http.Response response = await http.post(
      Uri.parse("$_url/login"),
      headers: _header,
      body: jsonEncode(
        <String, String>{'username': username, 'password': password},
      ),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String username,
    String password,
  ) async {
    final http.Response response = await http.post(
      Uri.parse("$_url/register"),
      headers: _header,
      body: jsonEncode(<String, String>{
        'name': name,
        'username': username,
        'password': password
      }),
    );
    return jsonDecode(response.body);
  }
}
