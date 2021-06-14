import 'package:flutter/cupertino.dart';
import './menu.dart';

class Restaurant {
  final String id;
  final String title;
  final int mobile;
  final String image;
  List<MenuItem> menu;

  Restaurant({
    @required this.id,
    @required this.title,
    @required this.mobile,
    @required this.image,
    @required this.menu,
  });
}
