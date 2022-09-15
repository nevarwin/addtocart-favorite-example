import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';
import '../provider/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static const routeName = '/order-screen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future _orderFuture;

  Future orderFutureMethod() {
    return context.read<OrderProvider>().fetchOrderData();
  }

  @override
  void initState() {
    _orderFuture = orderFutureMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error Occured'),
            );
          }
          return Consumer<OrderProvider>(
            builder: (context, orders, child) => ListView.builder(
              itemCount: orders.getOrderItems.length,
              itemBuilder: (context, index) {
                return OrderItemWidget(
                  orderData: orders.getOrderItems[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
