import 'package:flutter/material.dart';

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
    return Column(
      children: [
        DrawerHeader(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.chiangmainews.co.th/wp-content/uploads/2016/12/07143833/10-3.jpg"),
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
                          "Store Username",
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
                          onPressed: () {},
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
        drawerItem(
            leadingIcon: Icon(Icons.list_sharp),
            title: "คำสั่งซื้อ",
            onTap: () {
              // Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.money),
            title: "รายได้",
            onTap: () {
              // Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.production_quantity_limits_outlined),
            title: "จัดการสินค้า",
            onTap: () async {
              Navigator.of(context)
                  .pushNamed(ProductManagementScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.wallet_travel),
            title: "กระเป๋าเงิน",
            onTap: () {
              Navigator.of(context).pushNamed(StoreWalletScreen.routeName);
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
