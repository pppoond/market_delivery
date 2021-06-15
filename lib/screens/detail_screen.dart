import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Detail"),
      ),
    );
  }
}
