import 'package:flutter/material.dart';

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
    return Column(
      children: [
        DrawerHeader(
          // decoration: BoxDecoration(color: Colors.orange),
          child: Row(
            children: [
              CircleAvatar(
                radius: 37,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Store Username",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 17,
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
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        drawerItem(
            leadingIcon: Icon(Icons.favorite),
            title: "จัดการสินค้า",
            onTap: () {
              // Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.shopping_cart),
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
              Navigator.of(context).restorablePushNamedAndRemoveUntil(
                  OverViewScreen.routeName, (route) => false);
              print("Log Out");
            }),
      ],
    );
  }
}
