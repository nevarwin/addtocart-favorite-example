import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_model.dart';
import '../provider/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-product-screen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _formGlobalKey = GlobalKey<FormState>();
  var _didChangeDependency = true;
  var _isLoading = false;

  var productTemplate = Product(
    id: null,
    title: '',
    price: 0,
  );

  var _initialValues = {
    // 'id': '',
    'title': '',
    'price': '',
  };

  @override
  void didChangeDependencies() {
    if (_didChangeDependency) {
      final productId = ModalRoute.of(context)?.settings.arguments ?? '';

      if (productId != '') {
        productTemplate = Provider.of<ProductProvider>(
          context,
          listen: false,
        ).findById(
          productId.toString(),
        );

        _initialValues = {
          // 'id': productTemplate.id,
          'title': productTemplate.title,
          'price': productTemplate.price.toString(),
        };
      }
    }
    _didChangeDependency = false;

    super.didChangeDependencies();
  }

  Future<void> _submitForm() async {
    var isValid = _formGlobalKey.currentState?.validate();

    if (!isValid!) {
      return;
    }

    _formGlobalKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    if (productTemplate.id != null) {
      await context.read<ProductProvider>().updateProduct(
            productTemplate.id,
            productTemplate,
          );
    } else {
      try {
        await context.read<ProductProvider>().addProduct(
              productTemplate,
            );
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('An error occured'),
              content: Text('Something went wrong $error'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay'),
                ),
              ],
            );
          },
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully added a new product'),
        duration: Duration(seconds: 1),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formGlobalKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initialValues['title'],
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                        textInputAction: TextInputAction.next,
                        onSaved: (newValue) {
                          productTemplate = Product(
                            id: productTemplate.id,
                            title: newValue!,
                            price: productTemplate.price,
                            isFavorite: productTemplate.isFavorite,
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
                        initialValue: _initialValues['price'],
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
                            isFavorite: productTemplate.isFavorite,
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
