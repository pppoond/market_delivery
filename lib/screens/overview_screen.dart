import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/screens/customer/customer_order_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../screens/favorite_screen.dart';

import '../widgets/restaurant_list.dart';
import '../widgets/badge.dart';
import '../widgets/menu_list.dart';
import '../widgets/drawer/app_drawer.dart';
import '../widgets/product/product_list.dart';
import '../widgets/store/store_list.dart';

import '../model/cart.dart';
import '../model/customer.dart';

class OverViewScreen extends StatelessWidget {
  static const routeName = "/overview-screen";

  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customers>(context, listen: false);
    customer.loginCheck();
    customer.findCustomer();
    customer.getCurrentLocation();
    return Stack(
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
            drawer: AppDrawer(),
            // floatingActionButton: Container(
            //   child: Consumer<Cart>(
            //     builder: (_, cartData, child) => (cartData.itemCount < 1)
            //         ? Container()
            //         : FloatingActionButton(
            //             onPressed: () {
            //               Navigator.of(context).pushNamed(CartScreen.routeName);
            //             },
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.only(top: 7),
            //                   child: Text(
            //                     "${cartData.itemCount}",
            //                     style: TextStyle(
            //                       fontSize: 20,
            //                     ),
            //                   ),
            //                 ),
            //                 Icon(
            //                   Icons.shopping_cart,
            //                   size: 26,
            //                 )
            //               ],
            //             ),
            //           ),
            //   ),
            // ),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              toolbarHeight: 45,
              elevation: 0,
              title: Text(
                "ตลาดสด", style: TextStyle(color: Colors.white),
                // style: GoogleFonts.kanit(
                //   textStyle: Theme.of(context).textTheme.headline6,
                // ),
              ),
              actions: [
                Consumer<Orders>(
                  builder: (ctx, orderData, child) {
                    if (orderData.orderByCustomerId.length < 1) {
                      return IconButton(
                        onPressed: () async {
                          if (customer.customerModel != null) {
                            await orderData.getOrderByCustomerId();
                            Navigator.of(context)
                                .pushNamed(CustomerOrderScreen.routeName);
                          } else {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.info,
                                title: 'กรุณาเข้าสู่ระบบ',
                                confirmBtnText: 'ตกลง');
                          }
                        },
                        icon: Icon(
                          Icons.receipt_sharp,
                        ),
                      );
                    }
                    return Badge(
                      color: Colors.red,
                      value: orderData.orderByCustomerId
                          .where((element) =>
                              element.status != '4' && element.status != '5')
                          .length
                          .toString(),
                      child: child,
                    );
                  },
                  child: IconButton(
                    onPressed: () async {
                      if (customer.customerModel != null) {
                        Navigator.of(context)
                            .pushNamed(CustomerOrderScreen.routeName);
                      } else {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.info,
                            title: 'กรุณาเข้าสู่ระบบ',
                            confirmBtnText: 'ตกลง');
                      }
                    },
                    icon: Icon(
                      Icons.receipt_sharp,
                    ),
                  ),
                ),
                // IconButton(
                //     onPressed: () {
                //       Navigator.of(context).pushNamed(FavoriteScreen.routeName);
                //     },
                //     icon: Icon(Icons.favorite_border)),
                Consumer<Cart>(
                  builder: (ctx, cartData, child) {
                    if (cartData.cart.length < 1) {
                      return IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                        ),
                      );
                    }
                    return Badge(
                      color: Colors.red,
                      value: cartData.cart.length.toString(),
                      child: child,
                    );
                  },
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 0),
                          child: ListView(
                            children: [
                              // MenuList(),
                              // RestaurantList(),
                              ProductList(),
                              StoreList()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    try {
      var status = await Permission.location.status;
      if (status.isDenied) {
        await Permission.location.request();
      }
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }
}
