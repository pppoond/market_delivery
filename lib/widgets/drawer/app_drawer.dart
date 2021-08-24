import 'package:flutter/material.dart';
import 'package:market_delivery/model/customer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './login_drawer.dart';
import './logout_drawer.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        // child: LogoutDrawer(),
        child: Consumer<Customers>(builder: (_, customerData, child) {
          customerData.loginCheck();
          return (customerData.loginStatus == true)
              ? LoginDrawer()
              : LogoutDrawer();
        }),
      ),
    );
  }
}
