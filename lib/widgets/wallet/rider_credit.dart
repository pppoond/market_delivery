import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../widgets/wallet/rider_credit_modal.dart';
import '../../widgets/wallet/rider_fill_modal.dart';

import '../../model/rider.dart';

class RiderCredit extends StatelessWidget {
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
                          "เครดิต",
                          style: TextStyle(fontSize: 22),
                        ),
                        // Spacer(),
                        // Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 16,
                        // )
                      ],
                    ),
                    Consumer<Riders>(
                      builder: (context, riderData, child) => Text(
                        "฿ ${riderData.riderModel!.credit}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor),
                      ),
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
            title: "เติมเครดิต",
            onTap: () {
              RiderFillModal.showModal(context: context);
            }),
        Divider(),
        drawerItem(
            leadingIcon: Icon(
              Icons.money,
            ),
            title: "ถอนเครดิตเข้ากระเป๋าเงิน",
            onTap: () {
              RiderCreditModal.showModal(ctx: context, orderId: "1");
            }),
        Divider(),
      ],
    );
  }
}
