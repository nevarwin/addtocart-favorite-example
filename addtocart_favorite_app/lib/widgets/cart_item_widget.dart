import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.title,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  final String title;
  final String price;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
