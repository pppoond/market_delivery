import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: _deviceSize.width * 0.45,
      height: _deviceSize.height * 0.20,
      child: Card(
        child: Column(
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
            )
          ],
        ),
      ),
    );
  }
}
