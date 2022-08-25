import 'package:addtocart_favorite_app/provider/cart.dart';
import 'package:addtocart_favorite_app/screens/cart_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              print(cart.getCartCount);

              return Badge(
                position: BadgePosition.topStart(),
                badgeContent: Text(
                  cart.getCartCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: SizedBox(
                  width: 50.0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ProductGridWidget(
        isFavorite: isFavorite,
      ),
    );
  }
}
