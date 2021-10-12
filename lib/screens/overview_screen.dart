import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
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
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: Container(
        child: Consumer<Cart>(
          builder: (_, cartData, child) => (cartData.itemCount < 1)
              ? Container()
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          "${cartData.itemCount}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        size: 26,
                      )
                    ],
                  ),
                ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text(
          "ตลาดสด",
          // style: GoogleFonts.kanit(
          //   textStyle: Theme.of(context).textTheme.headline6,
          // ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(FavoriteScreen.routeName);
              },
              icon: Icon(Icons.favorite_border)),
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
      body: Padding(
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
