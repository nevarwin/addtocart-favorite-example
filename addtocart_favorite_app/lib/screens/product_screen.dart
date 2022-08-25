import 'package:flutter/material.dart';

import '../widgets/product_grid_widget.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
      ),
      body: ProductGridWidget(
        isFavorite: isFavorite,
      ),
    );
  }
}
