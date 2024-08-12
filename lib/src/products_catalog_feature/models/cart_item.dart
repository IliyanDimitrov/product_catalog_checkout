import 'package:product_catalog_checkout/src/products_catalog_feature/models/product.dart';

class CartItem {
  final Product product;
  final String size;
  int quantity;

  CartItem({required this.product, required this.size, this.quantity = 1});
}