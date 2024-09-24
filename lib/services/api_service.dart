import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/models/category_model.dart';
import '../data/models/product_model.dart';


class ApiService {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1/';

  static Future<List<Product>> getProducts({int limit = 10}) async {
    final response = await http.get(Uri.parse('${baseUrl}products?limit=$limit'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('${baseUrl}categories'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
