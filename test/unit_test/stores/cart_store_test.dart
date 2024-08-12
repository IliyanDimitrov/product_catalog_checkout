import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/models/price.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/models/product.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/stores/cart_store.dart';

void main() {
  group('CartStore tests', () {

    // Arrange
    String sizeS = 'S';
    String sizeM = 'M';
    String sizeL = 'L';
    late CartStore cartStore;
    late Product testProduct;

    setUp(() {
      cartStore = CartStore();

      testProduct = const Product(
        id: '1', 
        sku: '1001', 
        name: 'Best Test Product', 
        brandName: 'Best Products', 
        mainImage: '', 
        price: Price(amount: '10.00', currency: 'GBP'), 
        sizes: ['S', 'M', 'L'], 
        stockStatus: 'IN STOCK', 
        colour: 'green', 
        description: 'The best product on the market that will help you test everyting.'
        );
    });

    test('should add item to cart', () {
      // Act
      cartStore.addItem(testProduct, sizeM);

      // Assert
      expect(cartStore.itemCount, 1);
      expect(cartStore.items[0].product, testProduct);
      expect(cartStore.items[0].size, sizeM);
      expect(cartStore.items[0].quantity, 1);
    });

    test('should increase quantity wnen adding same item twice', () {
      // Act
      cartStore.addItem(testProduct, sizeS);
      expect(cartStore.itemCount, 1);

      // Assert
      cartStore.addItem(testProduct, sizeS);
      expect(cartStore.items[0].quantity, 2);
    });

    test('should remove item from cart', () {
      // Arrange
      cartStore.addItem(testProduct, sizeL);
      // Act
      expect(cartStore.itemCount, 1);
      cartStore.removeItem(cartStore.items.first);
      // Assert
      expect(cartStore.itemCount, 0);
    });

    test('should clear all items from cart', () {
      // Arrange
      cartStore.addItem(testProduct, sizeM);
      cartStore.addItem(testProduct, sizeL);
      // Act
      expect(cartStore.items.length, 2);
      cartStore.clear();
      // Assert
      expect(cartStore.items.length, 0);
    });

    test('should calculation cart total amount', () {
      // Act
      cartStore.addItem(testProduct, sizeM);
      cartStore.addItem(testProduct, sizeL);
      // Assert
      expect(cartStore.total, 20.00);
    });
    test('should show correct cart items count', () {
      // Act
      cartStore.addItem(testProduct, sizeS);
      cartStore.addItem(testProduct, sizeM);
      cartStore.addItem(testProduct, sizeL);
      // Assert
      expect(cartStore.itemCount, 3);
    });
  });
}
