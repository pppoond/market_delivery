import 'package:flutter/material.dart';
import '../model/restaurants.dart';
import '../screens/detail_screen.dart';

class RestaurantList extends StatelessWidget {
  List<Restaurant> res = Restaurants().restaurants;
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
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
          SizedBox(
            height: 14,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.19,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: res.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        DetailScreen.routeName,
                        arguments: res[i].id,
                      );
                    },
                    child: Card(
                      elevation: 0.5,
                      shadowColor: Colors.grey.shade200,
                      child: Column(
                        children: [
                          Container(
                            child: ClipRRect(
                              child: Image.network(
                                res[i].image,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                            width: _deviceSize.width * 0.42,
                            height: _deviceSize.height * 0.13,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            width: _deviceSize.width * 0.42,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  res[i].title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
