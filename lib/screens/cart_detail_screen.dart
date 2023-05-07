import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart' show CartProvider;
import '../providers/order_provider.dart' show OrderProvider;

import '../widgets/cart_items.dart';

class CartDetailScreen extends StatelessWidget {
  static const routeName = '/cart-details';
  const CartDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    final orderData = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Details'),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    '\$${cartData.totalAmount}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                TextButton(
                    onPressed: () {
                      orderData.addOrders(
                        cartData.cartItems.values.toList(),
                        cartData.totalAmount,
                      );
                      cartData.clearCart();
                    },
                    child: Text(
                      'Order Now'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ))
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cartData.cartItems.length,
            itemBuilder: ((context, index) => CartItem(
                  cartData.cartItems.values.toList()[index].id,
                  cartData.cartItems.keys.toList()[index],
                  cartData.cartItems.values.toList()[index].title,
                  cartData.cartItems.values.toList()[index].price,
                  cartData.cartItems.values.toList()[index].quantity,
                )),
          ),
        )
      ]),
    );
  }
}
