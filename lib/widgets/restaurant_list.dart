import 'package:flutter/material.dart';
import '../model/restaurants.dart';

class RestaurantList extends StatelessWidget {
  List<Restaurant> res = Restaurants().restaurants;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Restaurant",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {},
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
          Container(
            height: MediaQuery.of(context).size.height * 0.19,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: res.length,
                itemBuilder: (context, i) {
                  return Container(
                    width: 200,
                    child: Card(
                      child: Text(res[i].title),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
