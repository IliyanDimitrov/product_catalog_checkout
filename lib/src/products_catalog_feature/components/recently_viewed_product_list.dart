import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/recently_viewed_products_store.dart';
import 'recently_viewed_product_card.dart';

class RecentlyViewedProductList extends StatelessWidget {
  const RecentlyViewedProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecentlyViewedProductsStore>(
      builder: (context, recentProductsStore, child) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('History:', style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 120),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recentProductsStore.recentlyViewedProducts.length,
                itemExtent: 100,
                itemBuilder: (context, index) {
                  final product = recentProductsStore.recentlyViewedProducts[index];
                  return SizedBox(
                    width: 120,
                    height: 120,
                    child: RecentlyViewedProductCard(product: product),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}