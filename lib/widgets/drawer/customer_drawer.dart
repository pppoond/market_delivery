import 'package:flutter/material.dart';
import 'package:market_delivery/screens/account_screen.dart';

import 'package:provider/provider.dart';

import '../../screens/favorite_screen.dart';
import '../../screens/cart_screen.dart';
import '../../screens/overview_screen.dart';

import '../../model/customer.dart';

import '../../utils/api.dart';

class CustomerDrawer extends StatelessWidget {
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
    final customer = Provider.of<Customers>(context, listen: false);
    return Column(
      children: [
        DrawerHeader(
          // decoration: BoxDecoration(color: Colors.orange),
          child: Consumer<Customers>(
            builder: (_, customerData, child) => Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 50,
                    backgroundImage:
                        (customerData.customerModel?.profileImage != null)
                            ? (customerData.customerModel?.profileImage != "")
                                ? NetworkImage(
                                    Api.imageUrl +
                                        customerData
                                            .customerModel!.profileImage,
                                  )
                                : AssetImage("assets/images/user.png")
                                    as ImageProvider

                            // :NetworkImage(
                            //     Api.imageUrl +
                            //         customerData.customerModel!.profileImage,
                            //   )
                            : AssetImage("assets/images/user.png"),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (customerData.customerModel != null)
                            ? "@" + customerData.customerModel!.username
                            : "",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Row(
                        children: [],
                      ),
                      Text(
                        (customerData.customerModel != null)
                            ? customerData.customerModel!.customerName
                            : "",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
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
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AccountScreen.routeName);
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
                ),
              ],
            ),
          ),
        ),
        drawerItem(
            leadingIcon: Icon(Icons.favorite),
            title: "ร้านที่ชอบ",
            onTap: () {
              Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.shopping_cart),
            title: "ตะกร้า",
            onTap: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.receipt_rounded),
            title: "คำสั่งซื้อของฉัน",
            onTap: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            }),
        Divider(),
        Spacer(),
        Divider(),
        drawerItem(
            title: "ออกจากระบบ",
            onTap: () {
              customer.logoutCustomer();
              print("Log Out");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  OverViewScreen.routeName, (route) => false);
            }),
      ],
    );
  }
}
