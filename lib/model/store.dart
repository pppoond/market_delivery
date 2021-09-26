import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'dart:io' as io;

import 'package:dio/dio.dart' as dio;

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final Store = StoreFromJson(jsonString);

import 'dart:convert';

Store StoreFromJson(String str) => Store.fromJson(json.decode(str));

String StoreToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    required this.storeId,
    required this.username,
    required this.password,
    required this.storeName,
    required this.storePhone,
    this.profileImage = "",
    this.wallet = "",
    this.lat = 0,
    this.lng = 0,
    required this.status,
    required this.timeReg,
  });

  String storeId;
  String username;
  String password;
  String storeName;
  String storePhone;
  dynamic profileImage;
  String wallet;
  double lat;
  double lng;
  int status;
  DateTime timeReg;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeId: json["store_id"],
        username: json["username"],
        password: json["password"],
        storeName: json["store_name"],
        storePhone: json["store_phone"],
        profileImage: json["profile_image"],
        wallet: json["wallet"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        status: json['status'],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "username": username,
        "password": password,
        "store_name": storeName,
        "store_phone": storePhone,
        "profile_image": profileImage,
        "wallet": wallet,
        "lat": lat,
        "lng": lng,
        "status": status,
        "time_reg": timeReg.toIso8601String(),
      };
}

class Stores with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  //-----------------------------------------variable-------------------------------------------
  Store _storeModel = Store(
      storeId: "",
      username: "",
      password: "",
      storeName: "",
      storePhone: "",
      status: 0,
      timeReg: DateTime.now());
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _storeNameTextController = TextEditingController();

  io.File? _file;
  //-------------------Getter_and_Setter----------------------------------------

  Store get storeModel => this._storeModel;

  set storeModel(Store value) => this._storeModel = value;

  get usernameTextController => this._usernameTextController;

  set usernameTextController(value) => this._usernameTextController = value;

  get passwordTextController => this._passwordTextController;

  set passwordTextController(value) => this._passwordTextController = value;

  get storeNameTextController => this._storeNameTextController;

  set storeNameTextController(value) => this._storeNameTextController = value;

  get file => this._file;

  set file(value) => this._file = value;
  //--------------------method-------------------------------------------------------------------------
  // Stores.onLoadClass() {
  //   findStore();
  //   debugPrint("Onload Store Class");
  // }

  Future<bool> loginStore(
      {required String username, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool login;
    var response = await http.post(Uri.parse(Api.loginStore), body: {
      'username': username,
      'password': password,
    });
    debugPrint(response.body);
    var results = jsonDecode(response.body);
    var result = results['result'];
    if (result['msg'] == 'success') {
      login = true;
    } else {
      login = false;
    }
    await findStore(username: result['username']);
    sharedPreferences.setString("type", "store");
    notifyListeners();
    return login;
  }

  void logoutStore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    notifyListeners();
  }

  Future<bool> register(
      {required String username,
      required String password,
      required String customerName,
      required String customerPhone}) async {
    bool register;
    var response = await http.post(Uri.parse(Api.registerCustomer), body: {
      'username': username,
      'password': password,
      'customer_name': customerName,
      'customer_phone': customerPhone,
    });

    var results = jsonDecode(response.body);
    debugPrint(results['msg']);
    var result = results['result'];
    if (results['msg'] == "success") {
      register = true;
    } else {
      register = false;
    }
    notifyListeners();
    return register;
  }

  Future<dynamic> addProduct() async {
    try {
      var results = await dio.Dio().post("", data: {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> findStore({String username = ""}) async {
    debugPrint("Find Store");
    debugPrint(username.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var response =
        await http.get(Uri.parse(Api.stores + "?find_username=${username}"));

    var result = jsonDecode(response.body);
    debugPrint(result.toString());
    // storeModel = Store.fromJson(result['result'][0]);
    _storeModel = Store(
      storeId: result['result'][0]['store_id'],
      username: result['result'][0]['username'],
      password: result['result'][0]['password'],
      storeName: result['result'][0]['store_name'],
      storePhone: result['result'][0]['store_phone'],
      status: result['result'][0]['status'],
      timeReg: DateTime.parse(result['result'][0]['time_reg']),
    );
    sharedPreferences.setString(
        "storeId", result['result'][0]['store_id'].toString());

    // debugPrint("catch error");
    // debugPrint(e.toString());
    // debugPrint("________________________");

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
  }

  Future<Null> uploadImage({required BuildContext context}) async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'store$i.jpg';
    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await dio.MultipartFile.fromFile(_file!.path, filename: nameImage);

      dio.FormData formData = dio.FormData.fromMap(map);
      await dio.Dio().post(Api.uploadImage, data: formData).then((value) {
        debugPrint("Response ==>> $value");
        debugPrint("name image");
        debugPrint("$nameImage");
        debugPrint("name image");
        // updateCustomer(ctx: context, profile_image: nameImage);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
