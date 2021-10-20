import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/rider.dart';

import '../../screens/wallet/rider_credit_screen.dart';
import '../../screens/wallet/rider_money_screen.dart';

class RiderWallet extends StatelessWidget {
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
    return SingleChildScrollView(
      child: Consumer<Riders>(
        builder: (context, riderData, child) => Container(
          child: Column(
            children: [
              SizedBox(
                height: 7,
              ),
              drawerItem(
                  leadingIcon: Icon(Icons.wallet_travel),
                  title: "กระเป๋าเครดิต \n${riderData.riderModel!.credit} บาท",
                  onTap: () async {
                    await riderData.findById();
                    Navigator.of(context)
                        .pushNamed(RiderCreditScreen.routeName);
                  }),
              Divider(),
              drawerItem(
                  leadingIcon: Icon(Icons.account_balance_wallet),
                  title: "กระเป๋าเงิน \n${riderData.riderModel!.wallet} บาท",
                  onTap: () {
                    Navigator.of(context).pushNamed(RiderMoneyScreen.routeName);
                  }),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
