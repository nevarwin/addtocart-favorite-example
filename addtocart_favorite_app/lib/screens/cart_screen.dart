import 'package:addtocart_favorite_app/provider/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '${cart.getTotalAmount}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Consumer<OrderProvider>(
                    builder: (context, order, child) {
                      return TextButton(
                        onPressed: () {
                          order.addOrders(
                            cart.getTotalAmount,
                            cart.getCartItems.values.toList(),
                          );
                          cart.clearCart();
                        },
                        child: const Text('Checkout'),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.getCartItems.length,
              itemBuilder: (context, index) {
                return CartItem(
                  id: cart.getCartItems.values.toList()[index].id,
                  productId: cart.getCartItems.keys.toList()[index],
                  title: cart.getCartItems.values.toList()[index].title,
                  price:
                      cart.getCartItems.values.toList()[index].price.toString(),
                  quantity: cart.getCartItems.values
                      .toList()[index]
                      .quantity
                      .toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
