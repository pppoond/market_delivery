import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer/store_drawer.dart';

import '../model/store.dart';

class StoreScreen extends StatelessWidget {
  static const routeName = "/store-screen";

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<Stores>(context, listen: false);
    storeProvider.findStoreById();
    return Scaffold(
      drawer: Drawer(
        child: StoreDrawer(),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("จัดการร้าน"),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid))),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "คำสั่งซื้อกำลังดำเนินการ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade500),
                ),
                Divider(),
                ListView.builder(
                    itemCount: 1,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.grey.shade300,
                        ),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text("คำสั่งซื้อ TL123"),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).accentColor,
                        style: BorderStyle.solid))),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "สำเร็จ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500),
                ),
                Divider(),
                ListView.builder(
                    itemCount: 1,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.grey.shade300,
                        ),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Text("คำสั่งซื้อ TL321"),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      )),
    );
  }
}
