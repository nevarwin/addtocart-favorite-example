import 'package:flutter/cupertino.dart';
import './cart.dart';

class Order {
  final String id;
  final double total;
  final DateTime date;
  final List<Cart> cartItems;

  Order({
    required this.id,
    required this.total,
    required this.date,
    required this.cartItems,
  });
}

class OrderProvider with ChangeNotifier {
  final List<Order> _orderItems = [];

  List<Order> get getOrderItems {
    return [..._orderItems];
  }

  void addOrders(
    double total,
    List<Cart> cartItems,
  ) {
    _orderItems.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        total: total,
        date: DateTime.now(),
        cartItems: cartItems,
      ),
    );
    notifyListeners();
  }
}
