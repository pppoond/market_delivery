import 'package:flutter/material.dart';

import '../../widgets/wallet/rider_wallet.dart';

class StoreWalletScreen extends StatelessWidget {
  static const routeName = "/store-wallet-screen";

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
      body: RiderWallet(),
    );
  }
}
