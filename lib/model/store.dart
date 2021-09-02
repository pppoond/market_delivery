import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

class Stores with ChangeNotifier {
  Future<bool> loginStore(
      {required String username, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool login;
    var response = await http.post(Uri.parse(Api.loginStore), body: {
      'username': username,
      'password': password,
    });
    print(response.body);
    if (response.body != null) {
      login = true;
    } else {
      login = false;
    }
    sharedPreferences.setString("type", "store");
    notifyListeners();
    return login;
  }

  void logoutStore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("type");
    notifyListeners();
  }

  Future<bool> register({
    required String username,
    required String password,
    required String customerName,
    required String customerPhone,
  }) async {
    bool register;
    var response = await http.post(Uri.parse(Api.registerCustomer), body: {
      'username': username,
      'password': password,
      'customer_name': customerName,
      'customer_phone': customerPhone,
    });

    var results = jsonDecode(response.body);
    print(results['msg']);
    var result = results['result'];
    if (results['msg'] == "success") {
      register = true;
    } else {
      register = false;
    }
    notifyListeners();
    return register;
  }
}
