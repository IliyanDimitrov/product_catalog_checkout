import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/components/product_card.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/services/product_service.dart';
import 'components/cart_icon_with_badge.dart';
import 'components/recently_viewed_product_list.dart';
import 'models/product.dart';

/// Displays a list of SampleItems.
class ProductListView extends StatefulWidget {
  const ProductListView({
    super.key
  });

  static const routeName = '/';

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late Future<List<Product>> futureProducts;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: const [
          CartIconWithBadge(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: ProductService().fetchProducts(Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('An error occurred: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  return ProductList(products: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const RecentlyViewedProductList(),
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
