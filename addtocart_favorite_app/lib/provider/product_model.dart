import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  var id;
  final String title;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    final url = Uri.https(
      'testproject-68c84-default-rtdb.firebaseio.com',
      '/products/$id.json',
    );
    var oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final response = await http.patch(
      url,
      body: json.encode({
        'isFavorite': isFavorite,
      }),
    );
    if (response.statusCode >= 400) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
