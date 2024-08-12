import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:product_catalog_checkout/src/products_catalog_feature/models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts(http.Client client) async {
    final response = await client.get(Uri.parse('https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json'));

    if (response.statusCode == 200) {
      return compute(parseProducts, response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  List<Product> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody);
    final productsJson = parsed['data'] as List<dynamic>;
    List<Product> productList = <Product>[];

    for (dynamic productJson in productsJson) {
      Product product = Product.fromJson(productJson);
      productList.add(product);
    }

    return productList;
  }
}