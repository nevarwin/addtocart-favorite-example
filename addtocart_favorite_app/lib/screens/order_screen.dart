import 'package:addtocart_favorite_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../provider/order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static const routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.getOrderItems.length,
        itemBuilder: (context, index) {
          return OrderItemWidget(
            orderData: orders.getOrderItems[index],
          );
        },
      ),
    );
  }
}
