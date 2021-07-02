import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';

import '../widgets/restaurant_list.dart';
import '../widgets/badge.dart';

import '../model/cart.dart';

class OverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("Delivery"),
        actions: [
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
      body: Padding(
        padding: EdgeInsets.only(left: 16, bottom: 0),
        child: ListView(
          children: [
            RestaurantList(),
          ],
        ),
      ),
    );
  }
}
