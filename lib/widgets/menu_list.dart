import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../model/restaurants.dart';

import '../widgets/menu_list_item.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<Restaurants>(context, listen: false).menuItem;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Menu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(RestaurantScreen.routeName);
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
              itemCount: menu.length,
              itemBuilder: (context, i) => MenuListItem(
                menuId: menu[i].id,
                menuTitle: menu[i].title,
                menuImage: menu[i].image,
                menuPrice: menu[i].price,
                menuRestaurantId: menu[i].restaurantId,
                menuRestaurantTitle: menu[i].restaurantTitle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
