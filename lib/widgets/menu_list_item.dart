import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/product.dart';
import 'package:market_delivery/model/store.dart';
import 'package:market_delivery/screens/store/store_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';

import '../screens/detail_screen.dart';

class MenuListItem extends StatelessWidget {
  Product product;

  MenuListItem({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<Stores>(context, listen: false);
    final _deviceSize = MediaQuery.of(context).size;
    // double _discount = (menuPrice * 150) / 100;
    return InkWell(
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed(DetailScreen.routeName, arguments: menuRestaurantId);
        Navigator.of(context).pushNamed(
          StoreDetailScreen.routeName,
          arguments: product.storeId,
        );
      },
      child: Container(
        width: _deviceSize.width * 0.45,
        height: _deviceSize.height * 0.20,
        child: Card(
          key: ValueKey(product.productId),
          elevation: 0.5,
          shadowColor: Colors.grey.shade200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: _deviceSize.width * 0.50,
                height: _deviceSize.height * 0.20,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: Image.network(
                    Api.imageUrl +
                        'products/' +
                        product.productImages![0].proImgAddr,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 7, right: 7, top: 3),
                child: Text(
                  product.productName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 7,
                  right: 7,
                ),
                child: Text(
                  storeProvider.allStores
                      .firstWhere(
                          (element) => element.storeId == product.storeId)
                      .storeName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  left: 7,
                  right: 7,
                ),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      "฿ ${double.parse(product.price).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(
                      " / ${product.unit}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    // Text(
                    //   "฿ ${_discount.toStringAsFixed(0)}",
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.grey,
                    //       decoration: TextDecoration.lineThrough),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
