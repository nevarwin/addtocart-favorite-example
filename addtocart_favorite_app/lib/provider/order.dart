import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
  List<Order> _orderItems = [];

  List<Order> get getOrderItems {
    return [..._orderItems];
  }

  Future<void> fetchOrderData() async {
    final url = Uri.https(
      'testproject-68c84-default-rtdb.firebaseio.com',
      '/orders.json',
    );

    final response = await http.get(url);
    print(response.body);

    Map<String, dynamic> loadedOrders = json.decode(response.body);
    List<Order> emptyOrders = [];

    if (loadedOrders.isEmpty) {
      return;
    }

    loadedOrders.forEach((key, value) {
      emptyOrders.insert(
        0,
        Order(
          id: key,
          total: value['total'],
          date: DateTime.parse(value['date']),
          cartItems: (value['cartItems'] as List<dynamic>).map(
            (item) {
              return Cart(
                id: item['id'],
                price: item['price'],
                quantity: item['quantity'],
                title: item['title'],
              );
            },
          ).toList(),
        ),
      );
    });
    _orderItems = emptyOrders;
    notifyListeners();
  }

  Future<void> addOrders(
    double total,
    List<Cart> cartItems,
  ) async {
    final timestamp = DateTime.now();
    final url = Uri.https(
      'testproject-68c84-default-rtdb.firebaseio.com',
      '/orders.json',
    );

    final response = await http.post(
      url,
      body: json.encode({
        'total': total,
        'date': timestamp.toString(),
        'cartItems': cartItems
            .map((cartitems) => {
                  'id': cartitems.id,
                  'title': cartitems.title,
                  'price': cartitems.price,
                  'quantity': cartitems.quantity,
                })
            .toList(),
      }),
    );
    _orderItems.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        total: total,
        date: timestamp,
        cartItems: cartItems,
      ),
    );
    notifyListeners();
  }
}
