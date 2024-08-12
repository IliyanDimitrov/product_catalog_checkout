import 'package:flutter/material.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/stores/cart_store.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartStore>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      leading: Image.network(item.product.mainImage),
                      title: Text(item.product.name),
                      subtitle: Text(
                          'Size: ${item.size}, Quantity: ${item.quantity}, Price: £${item.product.price.amount}'),
                      trailing: IconButton(
                          onPressed: () => cart.removeItem(item),
                          icon: const Icon(Icons.delete)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: £${cart.total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Checkout Logic Implementation
                  },
                  child: const Text('Checkout'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
