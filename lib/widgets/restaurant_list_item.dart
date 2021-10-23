import 'package:flutter/material.dart';
import 'package:market_delivery/model/customer.dart';
import 'package:market_delivery/model/store.dart';
import 'package:market_delivery/screens/store/store_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:market_delivery/utils/calculate_distance.dart';
import 'package:provider/provider.dart';

import '../screens/detail_screen.dart';

class RestaurantListItem extends StatelessWidget {
  Store store;

  RestaurantListItem({
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    final customerProvider = Provider.of<Customers>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          StoreDetailScreen.routeName,
          arguments: store.storeId,
        );
      },
      child: Card(
        key: ValueKey(store.storeId),
        elevation: 0.5,
        shadowColor: Colors.grey.shade200,
        child: Column(
          children: [
            Container(
              child: ClipRRect(
                child: Image.network(
                  Api.imageUrl + 'profiles/' + store.profileImage,
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
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              width: _deviceSize.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.storeName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  customerProvider.lat == null
                      ? SizedBox()
                      : Text(
                          'ระยะห่าง ' +
                              CalculateDistance.calDistanceLatLng(
                                      lat1: customerProvider.lat!,
                                      lng1: customerProvider.lng!,
                                      lat2: store.lat,
                                      lng2: store.lng)
                                  .toString() +
                              ' Km',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
