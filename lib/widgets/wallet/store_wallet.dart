import 'package:flutter/material.dart';

class StoreWallet extends StatelessWidget {
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
        drawerItem(
            leadingIcon: Icon(Icons.account_balance_wallet),
            title: "กระเป๋าเงิน \n350 บาท",
            onTap: () {}),
      ],
    );
  }
}
