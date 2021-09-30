import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../screens/store/store_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';

import '../../model/store.dart';

class StoreListItem extends StatelessWidget {
  Store store;

  StoreListItem({required this.store});

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
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
              height: _deviceSize.width * 0.15,
              child: ClipRRect(
                child: store.profileImage != null
                    ? store.profileImage != ''
                        ? FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              Api.imageUrl + "stores/" + store.profileImage,
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
                  Text(
                    "1.3 km",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
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
