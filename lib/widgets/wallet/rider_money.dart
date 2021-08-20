import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RiderMoney extends StatelessWidget {
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.grey.shade200,
            elevation: 0,
            child: InkWell(
              onTap: () {
                // Navigator.of(context).pushNamed(RiderOrderScreen.routeName);
              },
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "เงิน",
                          style: TextStyle(fontSize: 22),
                        ),
                        // Spacer(),
                        // Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 16,
                        // )
                      ],
                    ),
                    Text(
                      "฿ 1000",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // Divider(),s
        drawerItem(
            leadingIcon: Icon(
              Icons.money,
            ),
            title: "ถอนเงินเข้าบัญชี",
            onTap: () {}),
        Divider(),
      ],
    );
  }
}
