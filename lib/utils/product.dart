import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tpm_final_project/models/product.dart';

class ProductApi {
  static String baseUrl = "http://localhost:3002/products";
  static const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<Map<String, dynamic>> getProductsByCategory(
    String categoryId,
  ) async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/category/$categoryId"),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getProductTotal() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/total"),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getProductTotalPrice() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/total/price"),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getProductTotalByCategory(
    String categoryId,
  ) async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/total/$categoryId"),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getMaxPriceProduct() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/max/price"),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> addProduct(
    Product product,
    String categoryId,
  ) async {
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/$categoryId"),
      headers: headers,
      body: jsonEncode(<String, String>{
        'name': product.name!,
        'qty': product.qty!.toString(),
        'price': product.price!.toString(),
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> editTodo(Product product) async {
    final http.Response response = await http.put(
      Uri.parse("$baseUrl/${product.id}"),
      headers: headers,
      body: jsonEncode(<String, String>{
        'name': product.name!,
        'qty': product.qty.toString(),
        'price': product.price.toString(),
        'category_id': product.categoryId.toString(),
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> deleteTodo(String id) async {
    final http.Response response = await http.delete(Uri.parse("$baseUrl/$id"));
    return jsonDecode(response.body);
  }
}
