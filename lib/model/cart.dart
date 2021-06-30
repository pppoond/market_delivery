import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String date;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.date,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _carts = {};
  Map<String, CartItem> get cart {
    return {..._carts};
  }

  void addItemToCart({
    required String menuId,
    required String title,
    required double price,
    required int quantity,
    required String restaurantTitle,
  }) {
    print([menuId, title, price, quantity, restaurantTitle]);
  }
}
