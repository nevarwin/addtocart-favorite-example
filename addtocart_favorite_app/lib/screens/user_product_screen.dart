import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../provider/product_provider.dart';
import '../widgets/user_product_item_widget.dart';
import './edit_product_screen.dart';

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
      body: RefreshIndicator(
        // TODO: review
        onRefresh: () async {
          print('refresh');
          await context.read<ProductProvider>().fetchProductData();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
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
        ),
      ),
    );
  }
}
