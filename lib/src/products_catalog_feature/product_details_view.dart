import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/cart_icon_with_badge.dart';
import 'components/recently_viewed_product_list.dart';
import 'models/product.dart';
import 'stores/cart_store.dart';

/// Displays detailed information about a SampleItem.
class ProductDetailsView extends StatefulWidget {
  static const routeName = '/product';

  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: const [
          CartIconWithBadge(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.mainImage.isNotEmpty)
                    Center(
                      child: Image.network(
                        product.mainImage,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 300,
                            color: Colors.grey[300],
                            child: const Center(
                                child: Text('Image not available')),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Brand: ${product.brandName}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: ${product.price.currency} ${product.price.amount}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text('SKU: ${product.sku}'),
                  const SizedBox(height: 10),
                  Text('Availability: ${product.stockStatus}'),
                  const SizedBox(height: 10),
                  Text('Colour: ${product.colour}'),
                  const SizedBox(height: 20),
                  Text(
                    'Description:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(product.description),
                  const SizedBox(height: 20),
                  Text(
                    'Available Sizes:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 10,
                    children: product.sizes
                        .map((size) => ChoiceChip(
                              label: Text(size),
                              selected: selectedSize == size,
                              onSelected: (selected) {
                                setState(() {
                                  selectedSize = selected ? size : null;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: selectedSize != null
                          ? () {
                              Provider.of<CartStore>(context, listen: false)
                                  .addItem(product, selectedSize!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Added to cart')),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const RecentlyViewedProductList(),
        ],
      ),
    );
  }
}
