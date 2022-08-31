import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-product-screen';

  @override
  Widget build(BuildContext context) {
    final priceFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(priceFocusNode);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: priceFocusNode,
                  onFieldSubmitted: (_) {
                    // FocusScope.of(context).requestFocus(priceFocusNode);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
