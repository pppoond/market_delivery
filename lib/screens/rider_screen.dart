import 'package:flutter/material.dart';

import '../widgets/drawer/rider_drawer.dart';

class RiderScreen extends StatelessWidget {
  static const routeName = "/rider-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(child: RiderDrawer()),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("หน้าหลัก"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
    );
  }
}
