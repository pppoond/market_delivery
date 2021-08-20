import 'package:flutter/material.dart';

import '../widgets/drawer/store_drawer.dart';

class StoreScreen extends StatelessWidget {
  static const routeName = "/store-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(child: StoreDrawer()),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("จัดการร้าน"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
    );
  }
}
