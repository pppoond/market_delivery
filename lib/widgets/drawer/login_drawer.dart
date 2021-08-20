import 'package:flutter/material.dart';

import '../../widgets/drawer/rider_drawer.dart';
import '../../widgets/drawer/customer_drawer.dart';
import '../../widgets/drawer/store_drawer.dart';

class LoginDrawer extends StatelessWidget {
  String isWho = "rider";

  @override
  Widget build(BuildContext context) {
    return (isWho == "customer")
        ? CustomerDrawer()
        : (isWho == "rider")
            ? RiderDrawer()
            : (isWho == "store")
                ? StoreDrawer()
                : Container();
  }
}
