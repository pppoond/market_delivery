import 'package:flutter/material.dart';
import 'package:market_delivery/screens/rider/edit_rider_profile_screen.dart';
import 'package:market_delivery/screens/rider/rider_work_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';
import '../../model/rider.dart';

import '../../screens/overview_screen.dart';
import '../../screens/wallet/rider_wallet_screen.dart';
import '../../screens/income/rider_income_screen.dart';

class RiderDrawer extends StatelessWidget {
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
    final rider = Provider.of<Riders>(context, listen: false);
    return Column(
      children: [
        Consumer<Riders>(
          builder: (context, riderData, child) => DrawerHeader(
            // decoration: BoxDecoration(color: Colors.orange),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: riderData.riderModel!.profileImage != null
                      ? riderData.riderModel!.profileImage != ""
                          ? NetworkImage(Api.imageUrl +
                              'profiles/' +
                              riderData.riderModel!.profileImage.toString())
                          : AssetImage('assets/images/user.png')
                              as ImageProvider
                      : AssetImage('assets/images/user.png'),
                  radius: 37,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      riderData.riderModel!.riderName,
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
                      onPressed: () async {
                        await riderData.findById();
                        await riderData.setTextField();
                        await riderData.resetFile();
                        Navigator.of(context)
                            .pushNamed(EditRiderProfileScreen.routeName);
                      },
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
        ),
        drawerItem(
            leadingIcon: Icon(Icons.account_balance_wallet),
            title: "กระเป๋าเงิน",
            onTap: () async {
              await rider.findById();
              Navigator.of(context).pushNamed(RiderWalletScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.money),
            title: "รายได้",
            onTap: () {
              Navigator.of(context).pushNamed(RiderIncomeScreen.routeName);
            }),
        // Divider(),
        // drawerItem(
        //     leadingIcon: Icon(Icons.shopping_cart),
        //     title: "My Cart",
        //     onTap: () {
        //       Navigator.of(context).pushNamed(CartScreen.routeName);
        //     }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.receipt),
            title: "งานของฉัน",
            onTap: () {
              Navigator.of(context).pushNamed(RiderWorkScreen.routeName);
            }),
        // Divider(),
        // drawerItem(
        //     leadingIcon: Icon(Icons.shopping_cart),
        //     title: "My Cart",
        //     onTap: () {
        //       Navigator.of(context).pushNamed(CartScreen.routeName);
        //     }),
        Divider(),
        Spacer(),
        Divider(),
        drawerItem(
            title: "ออกจากระบบ",
            onTap: () {
              rider.logoutRider();
              Navigator.of(context).restorablePushNamedAndRemoveUntil(
                  OverViewScreen.routeName, (route) => false);
            }),
      ],
    );
  }
}
