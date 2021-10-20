// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'dart:math';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  final ImagePicker _picker = ImagePicker();
  //--------------variable-----------------------------

  List<Admin> _adminsList = [];

  io.File? _file;

  //----------------GetterSetter-----------------------

  List<Admin> get adminsList => this._adminsList;

  set adminsList(value) => this._adminsList = value;

  get file => this._file;

  set file(value) => this._file = value;

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

  Future<Null> chooseImage(BuildContext ctx, ImageSource imageSource) async {
    try {
      var object = await _picker.pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      _file = io.File(object!.path);
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    final DateFormat formatter = DateFormat('MMddyyyy');
    String createDate = formatter.format(DateTime.now());
    String nameImage = 'slip$i' + '_' + '$createDate.jpg';

    Map<String, dynamic> map = Map();
    map['file'] =
        await dio.MultipartFile.fromFile(_file!.path, filename: nameImage);

    dio.FormData formData = dio.FormData.fromMap(map);
    await dio.Dio().post(Api.uploadRiderImage, data: formData).then((value) {
      debugPrint("Response ==>> $value");
      debugPrint("name image");
      debugPrint("$nameImage");
      debugPrint("name image");
      // _profileImageController = TextEditingController(text: nameImage);
      // updateCustomer(ctx: context, profile_image: nameImage);
    });
  }

  Future<void> resetFile() async {
    _file = null;
    notifyListeners();
  }
}
