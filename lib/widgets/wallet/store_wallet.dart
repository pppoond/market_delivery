import 'package:flutter/material.dart';
import 'package:market_delivery/model/store.dart';
import 'package:provider/provider.dart';

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
        Consumer<Stores>(
          builder: (context, data, child) => drawerItem(
              leadingIcon: Icon(Icons.account_balance_wallet),
              title: "กระเป๋าเงิน \n${data.storeModel.wallet} บาท",
              onTap: () {}),
        ),
      ],
    );
  }
}
