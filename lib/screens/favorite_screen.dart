import 'package:flutter/material.dart';
import 'package:market_delivery/model/restaurants.dart';

import 'package:provider/provider.dart';

import '../model/cart.dart';

import '../screens/cart_screen.dart';

import '../widgets/badge.dart';
import '../widgets/favorite_list_item.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = "/favorite-screen";
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<Restaurants>(context).favorite;
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
          "Favorite",
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
      body: (favorite.length < 1)
          ? Center(
              child: Text(
                "ไม่มีร้านที่ถูกใจ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 10, top: 14),
                    child: Text(
                      "ร้านที่ฉันถูกใจ",
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
                    itemCount: favorite.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 1.7,
                    ),
                    itemBuilder: (context, i) {
                      return FavoriteListItem(
                        resId: favorite[i].id,
                        resImage: favorite[i].image,
                        resTitle: favorite[i].title,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
