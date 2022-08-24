import 'package:addtocart_favorite_app/provider/product_model.dart';
import 'package:addtocart_favorite_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_item_widget.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isFavorite = false;
    final productData = Provider.of<ProductProvider>(context);
    final product = isFavorite
        ? productData.getfavoriteProducts
        : productData.getProductList;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: product.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider<Product>.value(
            value: product[index],
            child: const ProductItemWidget(),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
