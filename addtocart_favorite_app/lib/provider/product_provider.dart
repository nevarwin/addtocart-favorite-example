import 'package:flutter/material.dart';

import 'product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _productList = [
    Product(
      id: DateTime.now().toIso8601String(),
      title: 'Doggo',
      price: 99.99,
    ),
    Product(
      id: DateTime.now().toIso8601String(),
      title: 'Shoe',
      price: 9.99,
    ),
  ];

  List<Product> get getProductList {
    return [..._productList];
  }

  List<Product> get getfavoriteProducts {
    return _productList.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _productList.firstWhere((product) => product.id == id);
  }
}
