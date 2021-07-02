import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';

import '../model/cart.dart';
import '../model/restaurants.dart';

import '../widgets/badge.dart';
import '../widgets/detail_list_item.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail-screen";
  @override
  Widget build(BuildContext context) {
    final resId = ModalRoute.of(context)!.settings.arguments as String;
    final resData = Provider.of<Restaurants>(context).findById(resId);

    final _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 0,
        backgroundColor: Colors.white,
        // title: Text("Detail"),
        actions: [
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
            SizedBox(
              height: 12,
            ),
            Container(
              height: _deviceSize.height * 0.32,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  resData.image,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Distance 3.2 km",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.grey.shade400,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "รายการอาหาร",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: resData.menu.length,
              itemBuilder: (ctx, i) => DetailListItem(
                id: resData.menu[i].id,
                foodImage: resData.menu[i].image,
                foodTitle: resData.menu[i].title,
                foodPrice: resData.menu[i].price,
                restaurantTitle: resData.menu[i].restaurantTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
