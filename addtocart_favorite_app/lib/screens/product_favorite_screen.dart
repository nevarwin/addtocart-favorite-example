import 'package:flutter/material.dart';

import '../widgets/product_grid_widget.dart';

class ProductFavoriteScreen extends StatelessWidget {
  const ProductFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const ProductGridWidget(),
    );
  }
}
