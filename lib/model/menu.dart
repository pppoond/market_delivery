import 'package:flutter/cupertino.dart';

class MenuItem {
  final String id;
  final double price;
  final String title;
  final String image;
  final String restaurantTitle;
  final String restaurantId;

  MenuItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.restaurantTitle,
    required this.restaurantId,
  });
}
