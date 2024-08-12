import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:product_catalog_checkout/src/products_catalog_feature/models/product.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/services/product_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ProductProvider tests', () {
    late ProductService productService;
    late MockHttpClient mockClient;

    setUp(() {
      mockClient = MockHttpClient();
      productService = ProductService();
      registerFallbackValue(Uri.parse('https://example.com'));
    });

    test('should return a list of products when HTTP call completes successfully', () async {
      // Arrange
      const jsonString = '''
      {
        "result": "success",
        "data": [
          {
            "id": "1",
            "SKU": "1210",
            "name": "Test Product",
            "brandName": "Test Brand",
            "mainImage": "https://example.com/image.jpg",
            "price": {
              "amount": "45.00",
              "currency": "GBP"
            },
            "sizes": ["S", "M", "L"],
            "stockStatus": "IN STOCK",
            "colour": "blue",
            "description": "This is a test product."
          }
        ]
      }
      ''';

      when(() => mockClient.get(any())).thenAnswer((_) async => http.Response(jsonString, 200));

      // Act
      final products = await productService.fetchProducts(mockClient);

      // Assert
      expect(products, isA<List<Product>>());
      expect(products.length, 1);
      expect(products[0].name, 'Test Product');
      expect(products[0].price.amount, '45.00');
    });

    test('should throw an exception when HTTP call completes with an error', () async {
      // Arrange
      when(() => mockClient.get(any())).thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => productService.fetchProducts(mockClient), throwsA(isA<Exception>()));
    });

    test('should correctly parse product JSON', () {
      // Arrange
      const jsonString = '''
      {
        "result": "success",
        "data": [
          {
            "id": "1",
            "SKU": "1210",
            "name": "Test Product",
            "brandName": "Test Brand",
            "mainImage": "https://example.com/image.jpg",
            "price": {
              "amount": "45.00",
              "currency": "GBP"
            },
            "sizes": ["S", "M", "L"],
            "stockStatus": "IN STOCK",
            "colour": "blue",
            "description": "This is a test product."
          }
        ]
      }
      ''';

      // Act
      final products = productService.parseProducts(jsonString);

      // Assert
      expect(products, isA<List<Product>>());
      expect(products.length, 1);
      expect(products[0].id, '1');
      expect(products[0].sku, '1210');
      expect(products[0].name, 'Test Product');
      expect(products[0].brandName, 'Test Brand');
      expect(products[0].mainImage, 'https://example.com/image.jpg');
      expect(products[0].price.amount, '45.00');
      expect(products[0].price.currency, 'GBP');
      expect(products[0].sizes, ['S', 'M', 'L']);
      expect(products[0].stockStatus, 'IN STOCK');
      expect(products[0].colour, 'blue');
      expect(products[0].description, 'This is a test product.');
    });
  });
}