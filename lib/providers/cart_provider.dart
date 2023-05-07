import 'package:flutter/material.dart';

class CartItem {
  final String id, title;
  final double price;
  final int quantity;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
    var amount = 0.0;
    _cartItems.forEach((key, cartItem) {
      amount += cartItem.price * cartItem.quantity;
    });
    return amount;
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void addCartItem(String productId, String title, double price) {
    if (_cartItems.containsKey(productId)) {
      // increase quantity
      _cartItems.update(
          productId,
          (existingProduct) => CartItem(
                id: existingProduct.id,
                title: existingProduct.title,
                price: existingProduct.price,
                quantity: existingProduct.quantity + 1,
              ));
    } else {
      // add cart item

      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    } else if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
        productId,
        (existingProduct) => CartItem(
            id: existingProduct.id,
            title: existingProduct.title,
            price: existingProduct.price,
            quantity: existingProduct.quantity - 1),
      );
      print('remove single item');
    } else {
      _cartItems.remove(productId);
      print('remove product');
    }
    notifyListeners();
  }
}
