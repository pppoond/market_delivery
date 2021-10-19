// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  Admin({
    required this.adminId,
    required this.username,
    required this.password,
    required this.adminName,
    required this.bankName,
    required this.accountName,
    required this.noBankAccount,
    required this.timeReg,
  });

  String adminId;
  String username;
  String password;
  String adminName;
  String bankName;
  String accountName;
  String noBankAccount;
  DateTime timeReg;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        adminId: json["admin_id"],
        username: json["username"],
        password: json["password"],
        adminName: json["admin_name"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
        noBankAccount: json["no_bank_account"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "admin_id": adminId,
        "username": username,
        "password": password,
        "admin_name": adminName,
        "bank_name": bankName,
        "account_name": accountName,
        "no_bank_account": noBankAccount,
        "time_reg": timeReg.toIso8601String(),
      };
}

class Admins with ChangeNotifier {
  //--------------variable-----------------------------

  List<Admin> _adminsList = [];

  //----------------GetterSetter-----------------------

  List<Admin> get adminsList => this._adminsList;

  set adminsList(value) => this._adminsList = value;

  //--------------Method-------------------------------

  Future<void> getAdmins() async {
    var uri = Api.admins;
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    var result = results['result'];
    for (var item in result) {
      _adminsList.add(Admin.fromJson(item));
    }
    debugPrint(result.toString());
    notifyListeners();
  }
}
