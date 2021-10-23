import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/screens/store/store_order_today_cancel_screen.dart';
import 'package:market_delivery/screens/store/store_order_today_screen.dart';
import 'package:market_delivery/screens/store/store_order_today_success_screen.dart';
import 'package:market_delivery/widgets/custom_switch_widget.dart';
import 'package:market_delivery/widgets/store/post_list.dart';
import 'package:market_delivery/widgets/store/post_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer/store_drawer.dart';

import '../model/store.dart';
import '../model/order.dart';

class StoreScreen extends StatelessWidget {
  static const routeName = "/store-screen";

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<Stores>(context, listen: false);
    final orderProvider = Provider.of<Orders>(context, listen: false);
    storeProvider.findStoreById();
    orderProvider.getOrderByStoreId();
    orderProvider.getOrderByStoreDateToday();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              drawer: Drawer(
                child: StoreDrawer(),
              ),
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                centerTitle: true,
                toolbarHeight: 45,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Text(
                  "จัดการร้าน",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Consumer<Stores>(
                    builder: (context, storeData, child) => CustomSwitchWidget(
                      onToggle: (value) {
                        if (value == true) {
                          storeData.storeModel.status = 1;
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: const Text('ออนไลน์'),
                            // action: SnackBarAction(
                            //   label: 'ตกลง',
                            //   textColor: Colors.white,
                            //   onPressed: () {
                            //     // Some code to undo the change.
                            //   },
                            // ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          storeData.storeModel.status = 0;
                          final snackBar = SnackBar(
                            content: const Text('ออฟไลน์'),
                            // action: SnackBarAction(
                            //   label: 'ตกลง',
                            //   onPressed: () {
                            //     // Some code to undo the change.
                            //   },
                            // ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        print(value);
                        storeData.updateStatus();
                        storeData.notifyListeners();
                      },
                      isActive: storeData.storeModel.status == 1 ? true : false,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  )
                  // IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                ],
              ),
              body: SafeArea(
                  child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            color: Colors.white),
                        child: Consumer<Orders>(
                          builder: (context, orderData, child) => ListView(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      StoreOrderTodayScreen.routeName);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.receipt_sharp,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ยอดขายวันนี้',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        orderData.orderByStoreDate.length
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      StoreOrderTodaySuccessScreen.routeName);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent.shade100,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'สำเร็จ',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        orderData.countOrderStoreDateTodayS4
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      StoreOrderTodayCancelScreen.routeName);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.cancel,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ยกเลิก',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        orderData.countOrderStoreStatus5.length
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              PostWidget(),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'ประชาสัมพันธ์',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              PostList(
                                storePost: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
