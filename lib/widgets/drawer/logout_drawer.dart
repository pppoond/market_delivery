import 'package:flutter/material.dart';

import '../../screens/auth_screen.dart';

class LogoutDrawer extends StatelessWidget {
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
        dense: true,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "คุณยังไม่ได้เข้าสู่ระบบ",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
            Text(
              "กรุณาเข้าสู่ระบบก่อนดำเนินการต่อ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        )),
        Divider(),
        drawerItem(
            leadingIcon: Icon(Icons.person),
            title: "Login / Sign Up",
            onTap: () {
              // print("Log Out");
              Navigator.of(context).pushNamed(AuthScreen.routeName);
            }),
      ],
    );
  }
}
