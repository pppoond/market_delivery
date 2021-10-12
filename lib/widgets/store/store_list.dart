import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/store/store_list_item.dart';

import '../../model/product.dart';
import '../../model/store.dart';

class StoreList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stores = Provider.of<Stores>(context, listen: false);
    stores.getAllStores();
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
                  // Navigator.of(context).pushNamed(MenuScreen.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "ร้านทั้งหมด",
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
            height: MediaQuery.of(context).size.height * 0.2,
            child: Consumer<Stores>(
              builder: (context, storeData, child) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: storeData.getOnlineStore.length > 0
                      ? storeData.getOnlineStore.length
                      : 0,
                  itemBuilder: (context, i) =>
                      StoreListItem(store: storeData.getOnlineStore[i])),
            ),
          )
        ],
      ),
    );
  }
}
