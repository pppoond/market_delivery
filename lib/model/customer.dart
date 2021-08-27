// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/api.dart';

class Customer {
  Customer({
    required this.customerId,
    required this.username,
    this.password,
    required this.customerName,
    required this.customerPhone,
    required this.sex,
    required this.timeReg,
  });

  final int customerId;
  final String username;
  final String? password;
  final String? customerName;
  final String customerPhone;
  final String sex;
  final DateTime timeReg;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["customer_id"],
        username: json["username"],
        password: json["password"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        sex: json["sex"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "username": username,
        "password": password,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "sex": sex,
        "time_reg": timeReg.toIso8601String(),
      };
}

class Customers with ChangeNotifier {
  Customer? _customerModel;
  bool? _loginStatus;
  String? _customerId;

  Customer? get customerModel {
    return _customerModel;
  }

  bool? get loginStatus {
    return _loginStatus;
  }

  String? get customerId {
    return _customerId;
  }

  Future<bool> findByUsername({required String username}) async {
    bool _usernameNull;
    var response =
        await http.get(Uri.parse("${Api.customer}?find_username=${username}"));
    var results = jsonDecode(response.body);
    print(results);
    var result = results['result']!;
    if (result["username"] != null) {
      _usernameNull = false;
    } else {
      _usernameNull = true;
    }
    return _usernameNull;
  }

  void findCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? customerId = sharedPreferences.getString('customerId');
    if (customerId != null) {
      var response =
          await http.get(Uri.parse("${Api.customer}?findid=${customerId}"));
      var results = jsonDecode(response.body);
      print("reeeeeeeeeeeeeeeeeeeeeeeeee");
      print(results);
      var result = results['result']!;
      _customerModel = Customer(
        customerId: result['customer_id'],
        customerName: result['customer_name'],
        customerPhone: result['customer_phone'],
        sex: result['sex'],
        timeReg: result['time_reg'],
        username: result['username'],
      );
    }

    notifyListeners();
  }

  Future<bool> loginCustomer(
      {required String username, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool login;
    var response = await http.post(Uri.parse(Api.loginCustomer), body: {
      'username': username,
      'password': password,
    });

    var results = jsonDecode(response.body);
    print(results['result']);
    var result = results['result'];

    if (result['msg'] == "success") {
      login = true;
      sharedPreferences.setString("type", "customer");
      sharedPreferences.setString(
          "customerId", result['customer_id'].toString());
      print(result['customer_id'].toString());
      findCustomer();
    } else {
      login = false;
    }
    _loginStatus = true;
    notifyListeners();
    return login;
  }

  void logoutCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("type");
    sharedPreferences.remove("customerId");
    _loginStatus = false;
    notifyListeners();
  }

  Future<bool> loginCheck() async {
    bool status;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? type = await sharedPreferences.getString("type");
    if (type == "customer") {
      status = true;
      _loginStatus = status;
    } else {
      status = false;
      _loginStatus = status;
    }
    print("Function Login Check = $status");
    // findCustomer();
    notifyListeners();
    return status;
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
