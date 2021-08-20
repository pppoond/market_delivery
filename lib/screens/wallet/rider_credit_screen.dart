import 'package:flutter/material.dart';

import '../../widgets/wallet/rider_credit.dart';

class RiderCreditScreen extends StatelessWidget {
  static const routeName = "/rider-credit-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("กระเป๋าเครดิต"),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
      body: RiderCredit(),
    );
  }
}
