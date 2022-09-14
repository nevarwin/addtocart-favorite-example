import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'product_model.dart';

class ProductProvider with ChangeNotifier {
  var uuid = const Uuid().v1();
  List<Product> _productList = [
    // Product(
    //   id: 'Id1',
    //   title: 'Doggo',
    //   price: 99.99,
    // ),
    // Product(
    //   id: 'Id2',
    //   title: 'Shoe',
    //   price: 4000,
    // ),
    // Product(
    //   id: 'Id3',
    //   title: 'Tshirt',
    //   price: 150,
    // ),
    // Product(
    //   id: 'Id4',
    //   title: 'Watch',
    //   price: 5000,
    // ),
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

  final url = Uri.https(
    'testproject-68c84-default-rtdb.firebaseio.com',
    '/products.json',
  );

  Future<void> fetchProductData() async {
    try {
      final response = await http.get(url);
      final productData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      productData.forEach((productId, productData) {
        loadedProducts.insert(
          0,
          Product(
            id: productId,
            title: productData['title'],
            price: productData['price'],
          ),
        );
      });

      _productList = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
      );
      _productList.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // TODO: review
  Future<void> updateProduct(
    String id,
    Product existingProduct,
  ) async {
    final productIndex = _productList.indexWhere((product) => product.id == id);
    final url = Uri.https(
      'testproject-68c84-default-rtdb.firebaseio.com',
      '/products/$id.json',
    );
    if (productIndex >= 0) {
      await http.patch(
        url,
        body: json.encode({
          'title': existingProduct.title,
          'price': existingProduct.price,
        }),
      );
      _productList[productIndex] = existingProduct;
      notifyListeners();
    }
  }

  Future<void> removeProduct(String id) async {
    final url = Uri.https(
      'testproject-68c84-default-rtdb.firebaseio.com',
      '/products/$id.json',
    );

    final productIndex = _productList.indexWhere((element) => element.id == id);
    Product productData = _productList[productIndex];

    _productList.removeAt(productIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _productList.add(productData);
    }

    notifyListeners();
  }
}
