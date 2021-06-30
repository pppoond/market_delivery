import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';

import '../widgets/restaurant_list.dart';
import '../widgets/badge.dart';

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
          Badge(
            color: Colors.red,
            value: "99",
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
