import 'package:flutter/material.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/models/product.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/product_details_view.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/stores/recently_viewed_products_store.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/stores/cart_store.dart';
import 'package:provider/provider.dart';


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<RecentlyViewedProductsStore>(context, listen: false)
          .addProduct(product);
        Navigator.pushNamed(context, 
          ProductDetailsView.routeName,
          arguments: product,
          );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: product.mainImage.isNotEmpty
                  ? Image.network(
                      product.mainImage,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('Image not available'));
                      },
                    )
                  : const Center(child: Text('No image')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.name.isNotEmpty ? product.name : 'No name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(product.price.amount.isNotEmpty
                      ? '${product.price.currency} ${product.price.amount}'
                      : 'Price not available'),
                  Text(product.brandName.isNotEmpty ? product.brandName : 'Brand not specified'),
                  FilledButton(onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Size'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: product.sizes.map((size) {
                              return ListTile(
                                title: Text(size),
                                onTap: () {
                                  Provider.of<CartStore>(context, listen: false)
                                  .addItem(product, size);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Added to cart')),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                      );
                    },
                    child: const Text('Add To Cart'),
                  ), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}