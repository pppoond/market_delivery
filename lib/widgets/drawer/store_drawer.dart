import 'package:flutter/material.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/screens/store/edit_store_profile_screen.dart';
import 'package:market_delivery/screens/store/store_order_screen.dart';
import 'package:market_delivery/screens/store/store_report_screen.dart';
import 'package:market_delivery/utils/api.dart';

import 'package:provider/provider.dart';

import '../../screens/store/product_management_screen.dart';

import '../../model/store.dart';

import '../../widgets/wallet/store_wallet.dart';

import '../../screens/overview_screen.dart';
import '../../screens/wallet/store_wallet_screen.dart';

class StoreDrawer extends StatelessWidget {
  Widget drawerItem({required String title, var leadingIcon, required onTap}) {
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: ListTile(
        leading: leadingIcon == null ? null : leadingIcon,
        title: Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        trailing:
            title == "Log Out" ? null : Icon(Icons.arrow_forward_ios, size: 16),
        dense: true,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Stores>(context, listen: false);
    final order = Provider.of<Orders>(context, listen: false);
    return Column(
      children: [
        Consumer<Stores>(
          builder: (context, storeData, child) => DrawerHeader(
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: storeData.storeModel.profileImage != null
                    ? storeData.storeModel.profileImage != ""
                        ? NetworkImage(Api.imageUrl +
                            'profiles/' +
                            storeData.storeModel.profileImage.toString())
                        : AssetImage('assets/images/store.png') as ImageProvider
                    : AssetImage('assets/images/store.png'),
                fit: BoxFit.cover,
              ),
            ),
            // decoration: BoxDecoration(color: Colors.orange),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: const FractionalOffset(0.0, 0.8),
                        end: const FractionalOffset(0.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            storeData.storeModel.storeName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.zero,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () async {
                              await storeData.resetFile();
                              await storeData.findStoreById();
                              await storeData.setTextField();
                              Navigator.of(context)
                                  .pushNamed(EditStoreProfileScreen.routeName);
                            },
                            child: Text(
                              "แก้ไขข้อมูลส่วนตัว",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        drawerItem(
            leadingIcon: Icon(Icons.list_sharp),
            title: "จัดการคำสั่งซื้อ",
            onTap: () async {
              await order.getOrderByStoreId();
              Navigator.of(context).pushNamed(StoreOrderScreen.routeName);
            }),
        Divider(),
        // drawerItem(
        //     leadingIcon: Icon(Icons.money),
        //     title: "รายได้",
        //     onTap: () {
        //       // Navigator.of(context).pushNamed(FavoriteScreen.routeName);
        //     }),
        // Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.production_quantity_limits_outlined),
            title: "จัดการสินค้า",
            onTap: () async {
              Navigator.of(context)
                  .pushNamed(ProductManagementScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.account_balance_wallet),
            title: "กระเป๋าเงิน",
            onTap: () async {
              await store.findStoreById();
              Navigator.of(context).pushNamed(StoreWalletScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.data_saver_off),
            title: "รายงาน",
            onTap: () async {
              // await store.findStoreById();
              Navigator.of(context).pushNamed(StoreReportScreen.routeName);
            }),
        Divider(),
        Spacer(),
        Divider(),
        drawerItem(
            title: "ออกจากระบบ",
            onTap: () {
              store.logoutStore();
              Navigator.of(context).restorablePushNamedAndRemoveUntil(
                  OverViewScreen.routeName, (route) => false);
              print("Log Out");
            }),
      ],
    );
  }
}
