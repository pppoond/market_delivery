import 'package:flutter/material.dart';
import '../widgets/restaurant_list.dart';

class OverViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("Delivery"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, bottom: 0),
        child: ListView(
          children: [
            RestaurantList(),
          ],
        ),
      ),
    );
  }
}
