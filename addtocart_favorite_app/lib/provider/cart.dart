import 'package:flutter/cupertino.dart';

class Cart {
  final String id;
  final String title;
  final int quantity;
  final double price;

  Cart({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, Cart> _cartItems = {};

  Map<String, Cart> get getCartItems {
    return {..._cartItems};
  }

  int get getCartCount {
    return getCartItems.length;
  }

  void addItem(
    String productId,
    String title,
    double price,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCartItem) {
          return Cart(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1,
          );
        },
        ifAbsent: () => Cart(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );

      notifyListeners();
    }
  }
}
