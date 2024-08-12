import 'package:flutter/material.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/cart_view.dart';
import 'package:product_catalog_checkout/src/products_catalog_feature/stores/cart_store.dart';
import 'package:provider/provider.dart';

class CartIconWithBadge extends StatelessWidget {
  const CartIconWithBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, CartView.routeName),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Consumer<CartStore>(
            builder: (_, cart, __) => cart.itemCount > 0
                ? Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cart.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}