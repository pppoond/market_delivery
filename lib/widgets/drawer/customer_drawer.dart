import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/cart.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/screens/account_screen.dart';
import 'package:market_delivery/screens/customer/customer_order_screen.dart';

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
    final cart = Provider.of<Cart>(context, listen: false);
    final order = Provider.of<Orders>(context, listen: false);
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
                          "??????????????????????????????????????????????????????",
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
            title: "??????????????????????????????",
            onTap: () {
              Navigator.of(context).pushNamed(FavoriteScreen.routeName);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.shopping_cart),
            title: "??????????????????",
            onTap: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            }),
        Divider(),
        Consumer<Orders>(
          builder: (context, orderData, child) => drawerItem(
              leadingIcon: Icon(Icons.receipt_rounded),
              title: "????????????????????????????????????????????????",
              onTap: () async {
                if (customer.customerModel != null) {
                  await orderData.getOrderByCustomerId();
                  Navigator.of(context)
                      .pushNamed(CustomerOrderScreen.routeName);
                } else {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.info,
                      title: '????????????????????????????????????????????????',
                      confirmBtnText: '????????????');
                }
              }),
        ),
        Divider(),
        Spacer(),
        Divider(),
        drawerItem(
            title: "??????????????????????????????",
            onTap: () async {
              customer.logoutCustomer();
              cart.resetStateCart();
              order.resetStateOrder();
              print("Log Out");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  OverViewScreen.routeName, (route) => false);
            }),
      ],
    );
  }
}
