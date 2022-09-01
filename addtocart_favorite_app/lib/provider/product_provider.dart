import 'package:flutter/material.dart';

import 'product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _productList = [
    Product(
      id: 'Id1',
      title: 'Doggo',
      price: 99.99,
    ),
    Product(
      id: 'Id2',
      title: 'Shoe',
      price: 4000,
    ),
    Product(
      id: 'Id3',
      title: 'Tshirt',
      price: 150,
    ),
    Product(
      id: 'Id4',
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

  void updateProduct(String id, Product existingProduct) {
    final productIndex = _productList.indexWhere((product) => product.id == id);

    if (productIndex >= 0) {
      _productList[productIndex] = existingProduct;
      notifyListeners();
    }
  }
}
