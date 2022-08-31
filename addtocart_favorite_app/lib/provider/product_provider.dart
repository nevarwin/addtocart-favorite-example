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
      price: 4000,
    ),
    Product(
      id: DateTime.now().toIso8601String(),
      title: 'Tshirt',
      price: 150,
    ),
    Product(
      id: DateTime.now().toIso8601String(),
      title: 'Watch',
      price: 5000,
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

  void addProduct(Product product) {
    final newProduct = Product(
      id: product.id,
      title: product.title,
      price: product.price,
    );
    _productList.add(newProduct);
    notifyListeners();
  }
}
