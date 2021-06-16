import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail-screen";
  @override
  Widget build(BuildContext context) {
    final resTitle = ModalRoute.of(context)!.settings.arguments as String;
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
              resTitle,
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
