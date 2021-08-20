import 'package:flutter/material.dart';

import '../../widgets/income/rider_income.dart';

class RiderIncomeScreen extends StatelessWidget {
  static const routeName = "/rider-income-screen";
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
      body: RiderIncome(),
    );
  }
}
