import 'package:flutter/material.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/models/cart_item.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/models/product.dart';

class CartStore extends ChangeNotifier{
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  double get total => _items.fold(0, (sum, item) => sum + (double.parse(item.product.price.amount) * item.quantity));

  void addItem(Product product, String size) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id && item.size == size);
    
    if(existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product, size: size));
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}