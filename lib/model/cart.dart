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

  int get itemCount {
    return _carts.length;
  }

  double get totalFood {
    double total = 0.0;
    _carts.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _carts.remove(productId);
    notifyListeners();
  }

  void addItemToCart({
    required String menuId,
    required String title,
    required double price,
    required int quantity,
    required String restaurantTitle,
  }) {
    print([menuId, title, price, quantity, restaurantTitle]);

    if (_carts.containsKey(menuId)) {
      _carts.update(
        menuId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + quantity,
          date: DateTime.now().toString(),
        ),
      );
    } else {
      _carts.putIfAbsent(
          menuId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: quantity,
              date: DateTime.now().toString()));
    }
    notifyListeners();
  }
}
