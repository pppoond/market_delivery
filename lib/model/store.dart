import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'dart:io' as io;

import 'package:dio/dio.dart' as dio;

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final Store = StoreFromJson(jsonString);

import 'dart:convert';

Store StoreFromJson(String str) => Store.fromJson(json.decode(str));

String StoreToJson(Store data) => json.encode(data.toJson());

// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    required this.storeId,
    required this.email,
    required this.username,
    required this.password,
    required this.storeName,
    required this.storePhone,
    required this.profileImage,
    required this.wallet,
    required this.lat,
    required this.lng,
    required this.status,
    required this.timeReg,
  });

  String storeId;
  String email;
  String username;
  String password;
  String storeName;
  String storePhone;
  String profileImage;
  String wallet;
  double lat;
  double lng;
  int status;
  DateTime timeReg;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        storeId: json["store_id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        storeName: json["store_name"],
        storePhone: json["store_phone"],
        profileImage: json["profile_image"],
        wallet: json["wallet"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        status: json["status"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "email": email,
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
      timeReg: DateTime.now(),
      email: '',
      lat: 0,
      lng: 0,
      profileImage: '404.png',
      wallet: '0');

  List<Store> _allStores = [];
  List<Store> _listStoreOnline = [];

  TextEditingController _storeIdTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _storePhoneTextController = TextEditingController();
  TextEditingController _storeNameTextController = TextEditingController();
  TextEditingController _profileImageTextController = TextEditingController();
  TextEditingController _latTextController = TextEditingController();
  TextEditingController _lngTextController = TextEditingController();

  io.File? _file;
  //-------------------Getter_and_Setter----------------------------------------

  Store get storeModel => this._storeModel;

  set storeModel(Store value) => this._storeModel = value;

  List<Store> get allStores => this._allStores;

  List<Store> get getOnlineStore {
    return this._listStoreOnline;
  }

  set allStores(List<Store> value) => this._allStores = value;

  get storeIdTextController => this._storeIdTextController;

  set storeIdTextController(value) => this._storeIdTextController = value;

  get emailTextController => this._emailTextController;

  set emailTextController(value) => this._emailTextController = value;

  get usernameTextController => this._usernameTextController;

  set usernameTextController(value) => this._usernameTextController = value;

  get passwordTextController => this._passwordTextController;

  set passwordTextController(value) => this._passwordTextController = value;

  get storePhoneTextController => this._storePhoneTextController;

  set storePhoneTextController(value) => this._storePhoneTextController = value;

  get storeNameTextController => this._storeNameTextController;

  set storeNameTextController(value) => this._storeNameTextController = value;

  get profileImageTextController => this._profileImageTextController;

  get latTextController => this._latTextController;

  set latTextController(value) => this._latTextController = value;

  get lngTextController => this._lngTextController;

  set lngTextController(value) => this._lngTextController = value;

  set profileImageTextController(value) =>
      this._profileImageTextController = value;

  get file => this._file;

  set file(value) => this._file = value;
  //--------------------method-------------------------------------------------------------------------
  // Stores.onLoadClass() {
  //   findStore();
  //   debugPrint("Onload Store Class");
  // }

  Future<void> getAllStores() async {
    _allStores.clear();
    await http.get(Uri.parse(Api.stores)).then((value) async {
      var results = jsonDecode(value.body);
      var result = results['result'];
      debugPrint(result.toString());
      for (var item in result) {
        _allStores.add(Store.fromJson(item));
      }
      debugPrint(_allStores.length.toString());
      await getStoreOnline();
      notifyListeners();
    });
  }

  Future<void> getStoreOnline() async {
    _listStoreOnline.clear();
    for (var item in _allStores) {
      if (item.status == 1) {
        _listStoreOnline.add(item);
      }
    }
  }

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
      await findStore(username: result['username']);
      sharedPreferences.setString("type", "store");
    } else {
      login = false;
    }

    notifyListeners();
    return login;
  }

  Future<String> updateStore() async {
    if (_file != null) {
      await uploadImage();
    }
    var uri = Api.updateStore;
    var response = await http.post(Uri.parse(uri), body: {
      'store_id': _storeIdTextController.text,
      'username': _usernameTextController.text,
      'store_phone': _storePhoneTextController.text,
      'store_name': _storeNameTextController.text,
      'profile_image': _profileImageTextController.text
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findStoreById();
    return results['msg'];
  }

  Future<String> updatePassword() async {
    var uri = Api.updateStorePassword;
    var response = await http.post(Uri.parse(uri), body: {
      'store_id': _storeIdTextController.text,
      'password': _passwordTextController.text
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findStoreById();
    _passwordTextController = TextEditingController(text: '');
    notifyListeners();
    return results['msg'];
  }

  Future<String> updateStatus() async {
    var uri = Api.updateStoreStatus;
    var response = await http.post(Uri.parse(uri), body: {
      'store_id': _storeModel.storeId,
      'store_status': _storeModel.status.toString(),
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findStoreById();
    notifyListeners();
    return results['msg'];
  }

  Future<String> updateWallet(
      {required String amount, required String storeId}) async {
    // _storeModel.wallet =
    //     (double.parse(_storeModel.wallet) + double.parse(amount)).toString();

    var uri = Api.updateStoreWallet;
    var response = await http.post(Uri.parse(uri), body: {
      'store_id': storeId,
      'wallet': amount,
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findStoreById();
    notifyListeners();
    return results['msg'];
  }

  Future<String> updateLatLng() async {
    print("Lattttt");
    print(_latTextController.text);
    print(_lngTextController.text);

    print("Lattttt");
    var uri = Api.updateStoreLatLng;
    var response = await http.post(Uri.parse(uri), body: {
      'store_id': _storeIdTextController.text,
      'lat': _latTextController.text,
      'lng': _lngTextController.text
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findStoreById();
    _passwordTextController = TextEditingController(text: '');
    notifyListeners();
    return results['msg'];
  }

  void logoutStore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    notifyListeners();
  }

  Future<String> register() async {
    var response = await http.post(Uri.parse(Api.stores), body: {
      'email': _emailTextController.text,
      'username': _usernameTextController.text,
      'password': _passwordTextController.text,
      'store_phone': _storePhoneTextController.text,
      'store_name': _storeNameTextController.text,
    });
    var results = jsonDecode(response.body);
    print(results.toString());
    var result = results;
    notifyListeners();
    return result['msg'];
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
    _storeModel = Store.fromJson(result['result'][0]);
    sharedPreferences.setString(
        "store_id", result['result'][0]['store_id'].toString());

    // debugPrint("catch error");
    // debugPrint(e.toString());
    // debugPrint("________________________");

    notifyListeners();
  }

  Future<void> findStoreById() async {
    debugPrint("Find Store By Id");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? storeId = await sharedPreferences.getString("store_id");
    var response = await http.get(Uri.parse(Api.stores + "?findid=${storeId}"));

    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    if (result.length > 0) {
      _storeModel = Store.fromJson(result[0]);
    }
    // storeModel = Store.fromJson(result['result'][0]);

    notifyListeners();
  }

  Future<bool> findUsername({var username}) async {
    var response =
        await http.get(Uri.parse(Api.stores + "?find_username=${username}"));

    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    if (result.length > 0) {
      _storeModel = Store.fromJson(result[0]);
      notifyListeners();
      return false;
    } else {
      notifyListeners();
      return true;
    }
    // storeModel = Store.fromJson(result['result'][0]);
  }

  Future<void> findById({required String storeId}) async {
    var response = await http.get(Uri.parse(Api.stores + "?findid=${storeId}"));

    var result = jsonDecode(response.body);
    debugPrint(result.toString());
    storeModel = Store.fromJson(result['result'][0]);
    // _storeModel = Store(
    //   storeId: result['result'][0]['store_id'],
    //   username: result['result'][0]['username'],
    //   password: result['result'][0]['password'],
    //   storeName: result['result'][0]['store_name'],
    //   storePhone: result['result'][0]['store_phone'],
    //   status: result['result'][0]['status'],
    //   timeReg: DateTime.parse(result['result'][0]['time_reg']),
    // );
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
    String nameImage = 'profile$i' + '_' + '$createDate.jpg';

    Map<String, dynamic> map = Map();
    map['file'] =
        await dio.MultipartFile.fromFile(_file!.path, filename: nameImage);

    dio.FormData formData = dio.FormData.fromMap(map);
    await dio.Dio().post(Api.uploadStoreImage, data: formData).then((value) {
      debugPrint("Response ==>> $value");
      debugPrint("name image");
      debugPrint("$nameImage");
      debugPrint("name image");
      _profileImageTextController = TextEditingController(text: nameImage);
      // updateCustomer(ctx: context, profile_image: nameImage);
    });
  }

  Future<void> setTextField() async {
    _storeIdTextController = TextEditingController(text: _storeModel.storeId);
    _usernameTextController = TextEditingController(text: _storeModel.username);
    _passwordTextController = TextEditingController();
    _storePhoneTextController =
        TextEditingController(text: _storeModel.storePhone);
    _storeNameTextController =
        TextEditingController(text: _storeModel.storeName);
    _profileImageTextController =
        TextEditingController(text: _storeModel.profileImage);
    notifyListeners();
  }

  Future<bool> checkNullControll() async {
    bool checkNull = false;
    if (_storeIdTextController.text != '' &&
        _usernameTextController.text != '' &&
        _storePhoneTextController.text != '' &&
        _storeNameTextController.text != '') {
      checkNull = true;
    } else {
      checkNull = false;
    }
    return checkNull;
  }

  Future<void> resetFile() async {
    _file = null;
    notifyListeners();
  }

  Future<Null> setLatLng(LatLng latLng) async {
    _storeModel.lat = latLng.latitude;
    _storeModel.lng = latLng.longitude;
    _latTextController =
        TextEditingController(text: latLng.latitude.toString());
    _lngTextController =
        TextEditingController(text: latLng.longitude.toString());
    // moveCamera();
    notifyListeners();
  }
}
