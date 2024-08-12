import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/models/price.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/models/product.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/stores/recently_viewed_products_store.dart';

void main() {
  group('RecentlyViewedProductsStore tests', () {
    // Arrange
    late RecentlyViewedProductsStore recentlyViewedProductsStore;
    late List<Product> testProducts;

    setUp(() {
      recentlyViewedProductsStore = RecentlyViewedProductsStore();
      testProducts = List.generate(
        5,
        (index) => Product(
          id: '${index + 1}',
          sku: '100${index + 1}',
          name: 'Test Product ${index + 1}',
          brandName: 'Test Brand ${index + 1}',
          mainImage: '',
          price: Price(amount: '${10.00 + index}', currency: 'GBP'),
          sizes: ['S', 'M', 'L'],
          stockStatus: 'IN STOCK',
          colour: 'Color ${index + 1}',
          description: 'This is test product ${index + 1}',
        ),
      );
    });

    test('should add product to recently viewed list', () {
      // Act
      recentlyViewedProductsStore.addProduct(testProducts[0]);

      // Assert
      expect(recentlyViewedProductsStore.recentlyViewedProducts.length, 1);
      expect(recentlyViewedProductsStore.recentlyViewedProducts[0], testProducts[0]);
    });

    test('should maintain reverse chronological order of viewed products', () {
      // Act
      for (var product in testProducts) {
        recentlyViewedProductsStore.addProduct(product);
      }

      // Assert
      expect(recentlyViewedProductsStore.recentlyViewedProducts.length, 5);
      expect(recentlyViewedProductsStore.recentlyViewedProducts[0], testProducts[4]);
      expect(recentlyViewedProductsStore.recentlyViewedProducts[4], testProducts[0]);
    });

    test('should move duplicate product to the front of the list', () {
      // Arrange
      for (var product in testProducts) {
        recentlyViewedProductsStore.addProduct(product);
      }

      // Act
      recentlyViewedProductsStore.addProduct(testProducts[2]);

      // Assert
      expect(recentlyViewedProductsStore.recentlyViewedProducts[0], testProducts[2]);
      expect(recentlyViewedProductsStore.recentlyViewedProducts.length, 5);
    });

    test('should limit recently viewed products list to 10 items', () {
      // Arrange
      List<Product> moreProducts = List.generate(
        15,
        (index) => Product(
          id: '${index + 1}',
          sku: '100${index + 1}',
          name: 'Test Product ${index + 1}',
          brandName: 'Test Brand ${index + 1}',
          mainImage: '',
          price: Price(amount: '${10.00 + index}', currency: 'GBP'),
          sizes: ['S', 'M', 'L'],
          stockStatus: 'IN STOCK',
          colour: 'Color ${index + 1}',
          description: 'This is test product ${index + 1}',
        ),
      );

      // Act
      for (var product in moreProducts) {
        recentlyViewedProductsStore.addProduct(product);
      }

      // Assert
      expect(recentlyViewedProductsStore.recentlyViewedProducts.length, 10);
      expect(recentlyViewedProductsStore.recentlyViewedProducts[0].name, 'Test Product 15');
      expect(recentlyViewedProductsStore.recentlyViewedProducts[9].name, 'Test Product 6');
    });
  });
}