import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../provider/product_model.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: products.id,
          );
        },
        child: GridTile(
          header: Container(
            color: Colors.black12,
            child: Text(
              products.title,
              textAlign: TextAlign.center,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              onPressed: () {
                products.toggleFavorite();
              },
              icon: Icon(
                products.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
            ),
            title: Text(
              '${products.price}',
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
          child: Container(
            color: Colors.amber[100],
          ),
        ),
      ),
    );
  }
}
