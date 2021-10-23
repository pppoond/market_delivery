import 'package:flutter/material.dart';
import 'package:market_delivery/model/store.dart';

import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';

import '../model/restaurants.dart';
import '../model/cart.dart';

import '../widgets/restaurant_list_item.dart';
import '../widgets/badge.dart';

class RestaurantScreen extends StatelessWidget {
  static const routeName = "/restaurant-screen";

  @override
  Widget build(BuildContext context) {
    final restaurant =
        Provider.of<Restaurants>(context, listen: false).restaurants;
    final store = Provider.of<Stores>(context, listen: false);
    return Scaffold(
      floatingActionButton: Container(
        child: Consumer<Cart>(
          builder: (_, cartData, child) => (cartData.itemCount < 1)
              ? Container()
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          "${cartData.itemCount}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        size: 26,
                      )
                    ],
                  ),
                ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text(
          "ร้าน",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4, bottom: 10, top: 14),
              child: Text(
                "ร้านทั้งหมด",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: store.getOnlineStore.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1.7,
              ),
              itemBuilder: (context, i) {
                return RestaurantListItem(
                  store: store.getOnlineStore[i],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
