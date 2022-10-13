import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import './cart_screen.dart';
import '../widgets/product_grid_widget.dart';
import '../widgets/app_drawer.dart';
import '../provider/cart.dart';
import '../provider/product_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final isFavorite = false;

  late Future _futureFavorite;

  Future futureFavoriteMethod() {
    return context.read<ProductProvider>().fetchProductData();
  }

  @override
  void initState() {
    _futureFavorite = futureFavoriteMethod();
    super.initState();
  }

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
        body: FutureBuilder(
          future: _futureFavorite,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return ProductGridWidget(
              isFavorite: isFavorite,
            );
          },
        ));
  }
}
