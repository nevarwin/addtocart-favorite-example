import 'package:addtocart_favorite_app/provider/product_provider.dart';
import 'package:addtocart_favorite_app/screens/edit_product_screen.dart';
import 'package:addtocart_favorite_app/widgets/user_product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  static const routeName = '/user-products-screen';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: productData.getProductList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              UserProductItemWidget(
                id: productData.getProductList[index].id,
                title: productData.getProductList[index].title,
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
