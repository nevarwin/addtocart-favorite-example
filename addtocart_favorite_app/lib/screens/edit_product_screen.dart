import 'package:addtocart_favorite_app/provider/product_model.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-product-screen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();

  final _formGlobalKey = GlobalKey<FormState>();

  var productTemplate = Product(
    id: '',
    title: '',
    price: 0.0,
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    var isValid = _formGlobalKey.currentState?.validate();

    if (!isValid!) {
      return;
    }

    _formGlobalKey.currentState?.save();
    print(productTemplate.title);
    print(productTemplate.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formGlobalKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (newValue) {
                    productTemplate = Product(
                      id: productTemplate.id,
                      title: newValue!,
                      price: productTemplate.price,
                    );
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(
                      _priceFocusNode,
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onSaved: (newValue) {
                    productTemplate = Product(
                      id: productTemplate.id,
                      title: productTemplate.title,
                      price: double.parse(newValue!),
                    );
                  },
                  onFieldSubmitted: (_) {
                    _submitForm();
                  },
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if ((value!.isEmpty) || (double.tryParse(value)! <= 0)) {
                      return 'Provide a valid price';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
