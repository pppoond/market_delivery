import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/store.dart';
import '../../screens/wallet/store_money_screen.dart';

class StoreWalletScreen extends StatelessWidget {
  static const routeName = "/store-wallet-screen";

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("กระเป๋าเงิน"),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<Stores>(
          builder: (context, riderData, child) => Container(
            child: Column(
              children: [
                SizedBox(
                  height: 7,
                ),
                drawerItem(
                    leadingIcon: Icon(Icons.account_balance_wallet),
                    title: "กระเป๋าเงิน \n${riderData.storeModel.wallet} บาท",
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(StoreMoneyScreen.routeName);
                    }),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
