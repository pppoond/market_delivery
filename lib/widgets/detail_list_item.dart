import 'package:flutter/material.dart';

class DetailListItem extends StatelessWidget {
  final String id;
  final String foodImage;
  final String foodTitle;
  final double foodPrice;
  final String restaurantTitle;

  const DetailListItem({
    required this.id,
    required this.foodImage,
    required this.foodTitle,
    required this.foodPrice,
    required this.restaurantTitle,
  });
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 0.5,
      shadowColor: Colors.grey.shade200,
      child: Container(
        height: _deviceSize.height * 0.15,
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
