import 'package:flutter/material.dart';
import 'package:market_delivery/model/product.dart';

import 'package:provider/provider.dart';

import '../model/restaurants.dart';

import '../widgets/menu_list_item.dart';

import '../screens/menu_screen.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<Products>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "รายการ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MenuScreen.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "See All",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.355,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menu.allOnlineProducts.length >= 10
                  ? 10
                  : menu.allOnlineProducts.length,
              itemBuilder: (context, i) => MenuListItem(
                product: menu.allOnlineProducts[i],
              ),
            ),
          )
        ],
      ),
    );
  }
}
