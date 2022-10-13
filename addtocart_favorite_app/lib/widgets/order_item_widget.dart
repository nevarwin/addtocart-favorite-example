import 'package:flutter/material.dart';

import '../provider/order.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  final Order orderData;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          orderData.total.toString(),
        ),
        subtitle: Column(
          children: [
            SizedBox(
              height: 100,
              child: ListView(
                children: orderData.cartItems
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.title),
                          Text('${e.quantity}x ${e.price}'),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
