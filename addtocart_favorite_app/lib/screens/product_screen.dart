import 'package:flutter/material.dart';

import '../provider/product_model.dart';
import '../widgets/product_grid_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int bottomNavBarIndex = 0;
    List<Widget> _pages = [
      ProductFavoritesScreen();
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
      ),
      body: const ProductGridWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
          ),
        ],
      ),
    );
  }
}
