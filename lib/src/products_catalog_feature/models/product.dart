import 'price.dart';

/// A placeholder class that represents an entity or model.
class Product {
  const Product({
    required this.id, 
    required this.sku,
    required this.name, 
    required this.brandName, 
    required this.mainImage,
    required this.price,
    required this.sizes,
    required this.stockStatus,
    required this.colour,
    required this.description
    });

  final String id;
  final String sku;
  final String name;
  final String brandName;
  final String mainImage;
  final Price price;
  final List<String> sizes;
  final String stockStatus;
  final String colour;
  final String description; 

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? "",
      sku: json['SKU']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      brandName: json['brandName']?.toString() ?? "",
      mainImage: json['mainImage']?.toString() ?? "",
      price: Price.fromJson(json['price'] ?? {}),
      sizes: (json['sizes'] as List<dynamic>?)
          ?.map((size) => size.toString())
          .toList() ?? [],
      stockStatus: json['stockStatus']?.toString() ?? "",
      colour: json['colour']?.toString() ?? "",
      description: json['description']?.toString() ?? "",
    );
  }
}
