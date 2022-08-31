import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import './cart_screen.dart';
import '../widgets/product_grid_widget.dart';
import '../provider/cart.dart';
import '../widgets/app_drawer.dart';

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
        title: const Text('Products'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                position: BadgePosition.topStart(),
                badgeContent: Text(
                  cart.getCartCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        CartScreen.routeName,
                      );
                    },
                    child: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductGridWidget(
        isFavorite: isFavorite,
      ),
    );
  }
}
