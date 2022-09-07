import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'product_model.dart';

class ProductProvider with ChangeNotifier {
  var uuid = const Uuid().v1();
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

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
      'testproject-68c84-default-rtdb.firebaseio.com',
      '/products.json',
    );

    return http
        .post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'price': product.price,
        },
      ),
    )
        .then((response) {
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
      );
      _productList.add(newProduct);
      notifyListeners();
    });
  }

  void updateProduct(String id, Product existingProduct) {
    final productIndex = _productList.indexWhere((product) => product.id == id);

    if (productIndex >= 0) {
      _productList[productIndex] = existingProduct;
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    _productList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
