import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/product_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const routeName = '/add-product';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var editedProduct = ProductModel(
    id: '',
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
  );
  var _isInit = true;
  var initialValues = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      final productID = ModalRoute.of(context)!.settings.arguments;
      if (productID != null) {
        final product = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productID as String);
        editedProduct = product;
        initialValues = {
          'id': editedProduct.id,
          'title': editedProduct.title,
          'description': editedProduct.description,
          'price': editedProduct.price.toString(),
          // 'imageUrl': editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageTextEditingController.text = editedProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageFocusNode.removeListener(_updateImageUrl);
    _imageFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageTextEditingController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageTextEditingController.text.startsWith('http') &&
              !_imageTextEditingController.text.startsWith('https')) ||
          (!_imageTextEditingController.text.endsWith('.png') &&
              !_imageTextEditingController.text.endsWith('.jpg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    var isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (editedProduct.id.isNotEmpty) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(editedProduct.id, editedProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(editedProduct);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: initialValues['title'],
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (title) {
                    if (title!.isEmpty) {
                      return 'Please enter a product title';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    editedProduct = ProductModel(
                      id: editedProduct.id,
                      title: newValue as String,
                      description: editedProduct.description,
                      imageUrl: editedProduct.imageUrl,
                      price: editedProduct.price,
                      isFavorite: editedProduct.isFavorite,
                    );
                  },
                ),
                TextFormField(
                  initialValue: initialValues['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (price) {
                    if (price!.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(price) == null) {
                      // if fail tryParse will return null
                      return 'Enter a valid number';
                    }
                    if (double.parse(price) <= 0) {
                      return 'Price should be greater than 0';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    editedProduct = ProductModel(
                      id: editedProduct.id,
                      title: editedProduct.title,
                      description: editedProduct.description,
                      imageUrl: editedProduct.imageUrl,
                      price: double.parse(newValue as String),
                      isFavorite: editedProduct.isFavorite,
                    );
                  },
                ),
                TextFormField(
                  initialValue: initialValues['description'],
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validator: (description) {
                    if (description!.isEmpty) {
                      return 'Please enter a product description';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    editedProduct = ProductModel(
                      id: editedProduct.id,
                      title: editedProduct.title,
                      description: newValue as String,
                      imageUrl: editedProduct.imageUrl,
                      price: editedProduct.price,
                      isFavorite: editedProduct.isFavorite,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: _imageTextEditingController.text.isEmpty
                          ? const Text('Enter Url')
                          : FittedBox(
                              child: Image.network(
                                _imageTextEditingController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Image Url'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageTextEditingController,
                        focusNode: _imageFocusNode,
                        validator: (imageUrl) {
                          if (imageUrl!.isEmpty) {
                            return 'Please enter image url.';
                          } else if (!imageUrl.startsWith('http') ||
                              !imageUrl.startsWith('https') &&
                                  !imageUrl.endsWith('.png') ||
                              !imageUrl.endsWith('.jpg')) {
                            return 'Enter a valid Image url';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (newValue) {
                          editedProduct = ProductModel(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: editedProduct.description,
                            imageUrl: newValue as String,
                            price: editedProduct.price,
                            isFavorite: editedProduct.isFavorite,
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
