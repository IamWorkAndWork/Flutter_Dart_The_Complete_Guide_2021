import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  set setTitle(String title) => this.title = title;
  set setDesctiption(String description) => this.description = description;
  set setPrice(double price) => this.price = price;
  set setImageUrl(String imageUrl) => this.imageUrl = imageUrl;

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
