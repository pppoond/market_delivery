import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../model/cart.dart';

import '../widgets/cart_list.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("Cart"),
      ),
      body: (cartItem.cart.length < 1)
          ? Center(
              child: Text(
                "No Selected Foods",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    color: Colors.white,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: cartItem.cart.length,
                        itemBuilder: (context, i) {
                          return CartList(
                            id: cartItem.cart.keys.toList()[i],
                            cartId: cartItem.cart.values.toList()[i].id,
                            cartTitle: cartItem.cart.values.toList()[i].title,
                            cartPrice: cartItem.cart.values.toList()[i].price,
                            cartQuantity:
                                cartItem.cart.values.toList()[i].quantity,
                          );
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 10),
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Summary",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Food",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "฿${cartItem.totalFood.toStringAsFixed(0)}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total : ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text(
                              "฿${cartItem.totalFood.toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}