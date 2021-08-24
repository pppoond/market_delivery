// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/api.dart';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    required this.result,
  });

  List<Result> result;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.customerId,
    required this.username,
    required this.password,
    required this.customerName,
    required this.customerPhone,
    required this.sex,
    required this.timeReg,
  });

  final int customerId;
  final String username;
  final String password;
  final String customerName;
  final String customerPhone;
  final String sex;
  final DateTime timeReg;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
  bool? _loginStatus;

  bool? get loginStatus {
    return _loginStatus;
  }

  Future<bool> loginRider(
      {required String username, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool login;
    var response = await http.post(Uri.parse(Api.loginCustomer), body: {
      'username': username,
      'password': password,
    });
    print(response.body);
    if (response.body != null) {
      login = true;
    } else {
      login = false;
    }
    sharedPreferences.setString("type", "customer");
    _loginStatus = await loginCheck();
    notifyListeners();
    return login;
  }

  void logoutCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("type");
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
    notifyListeners();
    return status;
  }
}
