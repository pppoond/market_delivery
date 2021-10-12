import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_delivery/utils/calculate_distance.dart';
import 'package:provider/provider.dart';
import '../../screens/store/store_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';

import '../../model/store.dart';
import '../../model/customer.dart';

class StoreListItem extends StatelessWidget {
  Store store;

  StoreListItem({required this.store});

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
        elevation: 0.0,
        // shadowColor: Colors.grey.shade200,
        // color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: _deviceSize.width * 0.42,
              height: double.infinity,
              child: ClipRRect(
                child: store.profileImage != null
                    ? store.profileImage != ''
                        ? FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              Api.imageUrl + "profiles/" + store.profileImage,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          )
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.asset("assets/images/404.png"))
                    : FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset("assets/images/404.png")),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            Consumer<Customers>(builder: (context, customerData, child) {
              return Container(
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
                            CalculateDistance.calDistanceLatLng(
                                    lat1: customerProvider.lat!,
                                    lng1: customerProvider.lng!,
                                    lat2: store.lat,
                                    lng2: store.lng)
                                .toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
