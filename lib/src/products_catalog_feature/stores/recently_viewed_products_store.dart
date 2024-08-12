import 'package:flutter/material.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/models/product.dart';

class RecentlyViewedProductsStore extends ChangeNotifier {
  final List<Product> _recentlyViewedProducts = [];
  
  List<Product> get recentlyViewedProducts => _recentlyViewedProducts;

  void addProduct(Product product) {
    if (_recentlyViewedProducts.contains(product)) {
      _recentlyViewedProducts.remove(product);
    }
    _recentlyViewedProducts.insert(0, product);
    if (_recentlyViewedProducts.length > 10) {
      _recentlyViewedProducts.removeLast();
    }
    notifyListeners();
  }
}

