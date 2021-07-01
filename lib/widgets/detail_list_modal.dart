import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';

class DetailListModal {
  static Future<dynamic> showModal(
    BuildContext ctx,
    String id,
    String title,
    double price,
    String image,
    String restaurantTitle,
  ) {
    int _counter = 1;
    double _calculatePrice = price;

    final cart = Provider.of<Cart>(ctx, listen: false);

    return showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            void itemCount(value) {
              setState(() {
                if (value == "+") {
                  if (_counter > 9) {
                    return;
                  }
                  _counter = _counter + 1;
                } else {
                  if (_counter < 2) {
                    return;
                  }
                  _counter = _counter - 1;
                }
                _calculatePrice = _counter * price;
                print(_calculatePrice);
              });
            }

            Widget counterButton(String icon) {
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  itemCount(icon);
                },
                child: Container(
                  width: 45,
                  height: 45,
                  padding: EdgeInsets.only(bottom: 4, left: 1),
                  alignment: Alignment.center,
                  child: Text(
                    icon,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }

            return Container(
              height: MediaQuery.of(ctx).size.height * 0.8,
              decoration: BoxDecoration(
                color: Color(0xff757575),
                border: Border(
                  top: BorderSide(
                    width: 0,
                    color: Color(0xff757575),
                  ),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(image),
                        SizedBox(height: 10),
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "฿${_calculatePrice.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(ctx).accentColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        counterButton("-"),
                        Text(
                          "$_counter",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        counterButton("+"),
                      ],
                    ),
                    SafeArea(
                      child: Container(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(ctx).accentColor,
                          ),
                          onPressed: () {
                            cart.addItemToCart(
                              menuId: id,
                              title: title,
                              price: price,
                              quantity: _counter,
                              restaurantTitle: restaurantTitle,
                            );
                            Navigator.of(ctx).pop();
                          },
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
