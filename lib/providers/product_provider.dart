import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String id, title, description, imageUrl;
  final double price;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
