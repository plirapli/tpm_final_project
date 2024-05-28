import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryApi {
  static String baseUrl = "http://localhost:3002/categories";
  static const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<Map<String, dynamic>> getCategories() async {
    final http.Response response = await http.get(
      Uri.parse(baseUrl),
    );
    return jsonDecode(response.body);
  }
}
