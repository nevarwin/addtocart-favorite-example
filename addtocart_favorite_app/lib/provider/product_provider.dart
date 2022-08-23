import 'package:flutter/material.dart';
import 'product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _productList = [
    Product(
      id: DateTime.now().toIso8601String(),
      title: 'Title1',
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

  Product findById(String id) {
    return _productList.firstWhere((product) => product.id == id);
  }
}
