import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';

class MenuListItem extends StatelessWidget {
  final String menuId;
  final String menuTitle;
  final String menuImage;
  final double menuPrice;
  final String menuRestaurantId;
  final String menuRestaurantTitle;

  const MenuListItem({
    required this.menuId,
    required this.menuTitle,
    required this.menuImage,
    required this.menuPrice,
    required this.menuRestaurantId,
    required this.menuRestaurantTitle,
  });

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    double _discount = (menuPrice * 150) / 100;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailScreen.routeName, arguments: menuRestaurantId);
      },
      child: Container(
        width: _deviceSize.width * 0.45,
        height: _deviceSize.height * 0.20,
        child: Card(
          key: ValueKey(menuId),
          elevation: 0.5,
          shadowColor: Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: _deviceSize.width * 0.50,
                height: _deviceSize.height * 0.20,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: Image.network(
                    menuImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 7, right: 7, top: 3),
                child: Text(
                  menuTitle,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 7,
                  right: 7,
                ),
                child: Text(
                  menuRestaurantTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  left: 7,
                  right: 7,
                ),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      "฿ ${menuPrice.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "฿ ${_discount.toStringAsFixed(0)}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
