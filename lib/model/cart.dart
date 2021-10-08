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
  //--------------------variable-----------------------

  List<Map<String, dynamic>> _paymentMethod = [
    {
      'cash_id': 1,
      'cash_method': 'ชำระเงินปลายทาง',
      'shipping_cost': '15',
    },
  ];

  Map<String, CartItem> _carts = {};

  //--------------GetterSetter----------------

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

  List<Map<String, dynamic>> get paymentMethod => this._paymentMethod;

  set paymentMethod(List<Map<String, dynamic>> value) =>
      this._paymentMethod = value;

  //---------------------Method----------------------

  void removeItem(String productId) {
    _carts.remove(productId);
    notifyListeners();
  }

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
