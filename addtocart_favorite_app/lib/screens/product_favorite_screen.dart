import 'package:flutter/material.dart';

import '../widgets/product_grid_widget.dart';

class ProductFavoriteScreen extends StatelessWidget {
  ProductFavoriteScreen({Key? key}) : super(key: key);
  var isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ProductGridWidget(isFavorite: isFavorite),
    );
  }
}
