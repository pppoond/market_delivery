import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/restaurants.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail-screen";
  @override
  Widget build(BuildContext context) {
    final resId = ModalRoute.of(context)!.settings.arguments as String;
    final resData = Provider.of<Restaurants>(context).findById(resId);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 0,
        backgroundColor: Colors.white,
        // title: Text("Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Text(
              "${resData.title}",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
