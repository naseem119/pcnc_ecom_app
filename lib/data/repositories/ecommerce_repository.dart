import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../models/category_model.dart';

class EcommerceRepository {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1/';

  // fetch all products from the API
  static Future<List<Product>> getProducts({int limit = 10}) async {
    final response = await http.get(Uri.parse('${baseUrl}products?limit=$limit'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // fetch all categories from the API
  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}categories'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // fetch products by category ID
  static Future<List<Product>> getProductsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('${baseUrl}categories/$categoryId/products'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }
}
