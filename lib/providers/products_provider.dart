import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_provider.dart';

class ProductsProvider with ChangeNotifier {
  final List<ProductModel> _items = [
    ProductModel(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductModel(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductModel(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductModel(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  // var showOnlyFavorites = false;

  List<ProductModel> get items {
    // if (showOnlyFavorites) {
    //   return _items.where((product) => product.isFavorite).toList();
    // }
    return [..._items];
  }

  List<ProductModel> get favItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  void addProduct(ProductModel product) {
    _items.add(ProductModel(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
    ));
    notifyListeners();
  }

  ProductModel findById(String productId) {
    return _items.firstWhere((product) => product.id == productId);
  }

  void updateProduct(String id, ProductModel updatedProduct) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  /* 
  void showFavoriteProduct() {
    showOnlyFavorites = true;
    notifyListeners();
  }

  void showAllProduct() {
    showOnlyFavorites = false;
    notifyListeners();
  }
  */
}
