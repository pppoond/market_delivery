import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/account/customer_account.dart';
import '../widgets/account/rider_account.dart';
import '../widgets/account/store_account.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = "/account-screen";

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String isWho = "";

  @override
  void initState() {
    // print("AccountScreen");
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   toolbarHeight: 45,
      //   elevation: 1,
      //   title: Text("บัญชีผู้ใช้"),
      //   actions: [],
      // ),
      body: (isWho == "customer")
          ? CustomerAccount()
          : (isWho == "store")
              ? StoreAccount()
              : (isWho == "rider")
                  ? RiderAccount()
                  : Container(),
    );
  }

  void checkLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isWho = (await sharedPreferences.getString('type'))!;
    setState(() {
      // print(isWho);
    });
  }
}
