import 'package:flutter/material.dart';
import 'package:market_delivery/model/product.dart';

class CartItem {
  Product product;
  int quantity;
  String date;

  CartItem({
    required this.product,
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
      total += double.parse(cartItem.product.price) * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _carts.remove(productId);
    notifyListeners();
  }

  // void addItemToCart({
  //   required String menuId,
  //   required String title,
  //   required double price,
  //   required int quantity,
  //   required String restaurantTitle,
  // }) {
  //   print([menuId, title, price, quantity, restaurantTitle]);

  //   if (_carts.containsKey(menuId)) {
  //     _carts.update(
  //       menuId,
  //       (existingCartItem) => CartItem(
  //         id: existingCartItem.id,
  //         title: existingCartItem.title,
  //         price: existingCartItem.price,
  //         quantity: existingCartItem.quantity + quantity,
  //         date: DateTime.now().toString(),
  //       ),
  //     );
  //   } else {
  //     _carts.putIfAbsent(
  //         menuId,
  //         () => CartItem(
  //             id: DateTime.now().toString(),
  //             title: title,
  //             price: price,
  //             quantity: quantity,
  //             date: DateTime.now().toString()));
  //   }
  //   notifyListeners();
  // }

  void addProductToCart(
      {required Product product, required int quantity}) async {
    if (_carts.containsKey(product.productId)) {
      _carts.update(
        product.productId,
        (existingCartItem) => CartItem(
          product: product,
          quantity: existingCartItem.quantity + quantity,
          date: DateTime.now().toString(),
        ),
      );
    } else {
      _carts.putIfAbsent(
          product.productId,
          () => CartItem(
              product: product,
              quantity: quantity,
              date: DateTime.now().toString()));
    }
    notifyListeners();
  }
}
