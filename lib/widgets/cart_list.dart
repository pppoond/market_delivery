import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';

class CartList extends StatelessWidget {
  final String id;
  final String cartId;
  final String cartTitle;
  final double cartPrice;
  final int cartQuantity;

  CartList({
    required this.id,
    required this.cartId,
    required this.cartTitle,
    required this.cartPrice,
    required this.cartQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Slidable(
      key: ValueKey(id),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      secondaryActions: [
        IconSlideAction(
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            cart.removeItem(id);
          },
        )
      ],
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          height: MediaQuery.of(context).size.height * 0.08,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                "฿${cartPrice.toStringAsFixed(0)} x $cartQuantity = ",
                          ),
                          TextSpan(
                              text: "฿${cartPrice * cartQuantity}",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold)),
                        ]),
                  ),
                ],
              ),
              Divider(
                height: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
