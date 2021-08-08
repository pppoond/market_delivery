import 'package:flutter/material.dart';

import '../../screens/favorite_screen.dart';
import '../../screens/cart_screen.dart';

class AppDrawer extends StatelessWidget {
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
    return Drawer(
      child: SafeArea(
        child: Column(
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
                        "Display Username",
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
                          "Edit my profile",
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
                title: "My Favorite",
                onTap: () {
                  Navigator.of(context).pushNamed(FavoriteScreen.routeName);
                }),
            Divider(),
            drawerItem(
                leadingIcon: Icon(Icons.shopping_cart),
                title: "My Cart",
                onTap: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
            Divider(),
            Spacer(),
            Divider(),
            drawerItem(
                title: "Log Out",
                onTap: () {
                  print("Log Out");
                }),
          ],
        ),
      ),
    );
  }
}
