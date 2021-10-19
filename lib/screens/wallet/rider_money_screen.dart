import 'package:flutter/material.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/model/withdraw_rider.dart';
import 'package:market_delivery/screens/wallet/rider_withdraw_history_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/wallet/rider_money.dart';

class RiderMoneyScreen extends StatelessWidget {
  static const routeName = "/rider-money-screen";
  @override
  Widget build(BuildContext context) {
    final riderProvider = Provider.of<Riders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("กระเป๋าเงิน"),
        actions: [
          Consumer<WithdrawRiders>(
            builder: (context, withdrawData, child) => IconButton(
                onPressed: () async {
                  await withdrawData.findWithdrawByRiderId(
                      riderId: riderProvider.riderModel!.riderId);
                  Navigator.of(context)
                      .pushNamed(RiderWithdrawHistoryScreen.routeName);
                },
                icon: Icon(Icons.history)),
          ),
        ],
      ),
      body: RiderMoney(),
    );
  }
}
