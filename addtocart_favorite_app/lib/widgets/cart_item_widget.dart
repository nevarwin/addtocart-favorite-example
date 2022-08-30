import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  final String id;
  final String price;
  final String productId;
  final String quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(productId),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content:
                  const Text('Do you want to remove the item from the cart?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(
          context,
          listen: false,
        ).removeCartItem(productId);
      },
      direction: DismissDirection.endToStart,
      // dismissThresholds: const {
      //   DismissDirection.endToStart: 0.4,
      // },
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.all(4),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 35,
        ),
      ),
      child: Card(
        elevation: 5.0,
        child: ListTile(
          title: Text(title),
          subtitle: Text('Price: $price'),
          trailing: Text(
            '$quantity x',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
