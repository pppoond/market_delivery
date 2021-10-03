import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

class Riders with ChangeNotifier {
  //------------------Variable---------------------
  TextEditingController _riderIdController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _riderPhoneController = TextEditingController();
  TextEditingController _riderNameController = TextEditingController();
  TextEditingController _sexController = TextEditingController();
  TextEditingController _riderStatusController = TextEditingController();
  TextEditingController _creditController = TextEditingController();
  TextEditingController _walletController = TextEditingController();

  //------------------GetterSetter---------------

  get riderIdController => this._riderIdController;

  set riderIdController(value) => this._riderIdController = value;

  get usernameController => this._usernameController;

  set usernameController(value) => this._usernameController = value;

  get passwordController => this._passwordController;

  set passwordController(value) => this._passwordController = value;

  get riderPhoneController => this._riderPhoneController;

  set riderPhoneController(value) => this._riderPhoneController = value;

  get riderNameController => this._riderNameController;

  set riderNameController(value) => this._riderNameController = value;

  get sexController => this._sexController;

  set sexController(value) => this._sexController = value;

  get riderStatusController => this._riderStatusController;

  set riderStatusController(value) => this._riderStatusController = value;

  get creditController => this._creditController;

  set creditController(value) => this._creditController = value;

  get walletController => this._walletController;

  set walletController(value) => this._walletController = value;

  //-------------------Method---------------------

  Future<void> updateCreditRider() async {}

  Future<void> updateWalletRider() async {}

  Future<void> updateRider() async {
    var uri = Api.updateRider;
    var response = await http.post(Uri.parse(uri), body: {
      'rider_id': _riderIdController.text,
      'username': _usernameController.text,
      'password': _passwordController.text,
      'rider_phone': _riderPhoneController.text,
      'rider_name': _riderNameController.text,
      'sex': _sexController.text,
      'credit': _creditController.text,
      'wallet': _walletController.text,
    });
  }

  Future<bool> loginRider(
      {required String username, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool login;
    var response = await http.post(Uri.parse(Api.loginRider), body: {
      'username': username,
      'password': password,
    });
    print(response.body);
    if (response.body != null) {
      login = true;
    } else {
      login = false;
    }
    sharedPreferences.setString("type", "rider");
    notifyListeners();
    return login;
  }

  void logoutRider() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("type");
    notifyListeners();
  }
}
