import 'package:flutter/material.dart';
import '../model/restaurants.dart';
import '../widgets/restaurant_list_item.dart';

import '../screens/restaurant_screen.dart';

class RestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Restaurant> res = Restaurants().restaurants;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ร้าน",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RestaurantScreen.routeName);
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
            height: MediaQuery.of(context).size.height * 0.20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: res.length,
              itemBuilder: (context, i) => RestaurantListItem(
                resId: res[i].id,
                resImage: res[i].image,
                resTitle: res[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
