import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';

import '../screens/favorite_screen.dart';
import '../screens/cart_screen.dart';

import '../widgets/badge.dart';
import '../widgets/account/customer_account.dart';
import '../widgets/account/rider_account.dart';
import '../widgets/account/store_account.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = "/account-screen";
  String isWho = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("Delivery"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FavoriteScreen.routeName);
              },
              icon: Icon(Icons.favorite_border)),
          Consumer<Cart>(
            builder: (ctx, cartData, child) {
              if (cartData.cart.length < 1) {
                return IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                );
              }
              return Badge(
                color: Colors.red,
                value: cartData.cart.length.toString(),
                child: child,
              );
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      body: (isWho == "customer")
          ? CustomerAccount()
          : (isWho == "store")
              ? StoreAccount()
              : (isWho == "rider")
                  ? RiderAccount()
                  : Container(),
    );
  }
}
