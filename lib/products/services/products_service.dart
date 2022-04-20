import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prueba_mi_aguila/products/models/products.dart';

import '../../utils/api.dart';

class ProductsService {
  Future<List<Products>> getProducts() async {
    final response = await http.get(Uri.parse(API.apiUrl));
    if (response.statusCode == 200) {
      List decoded = await jsonDecode(response.body);
      return decoded.map((product) => Products.fromJson(product)).toList();
    }

    return [];
  }
}
