import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyApi {
  static String baseUrl = "http://localhost:3002/currency";
  static const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<Map<String, dynamic>> convert(
    double value, {
    String currency = "idr",
  }) async {
    final http.Response response = await http.post(
      Uri.parse("$baseUrl?currency=$currency"),
      headers: headers,
      body: jsonEncode(<String, String>{'value': value.toString()}),
    );
    return jsonDecode(response.body);
  }
}
