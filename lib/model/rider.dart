import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

// To parse this JSON data, do
//
//     final rider = riderFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final rider = riderFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final rider = riderFromJson(jsonString);

import 'dart:convert';

Rider riderFromJson(String str) => Rider.fromJson(json.decode(str));

String riderToJson(Rider data) => json.encode(data.toJson());

class Rider {
  Rider({
    required this.riderId,
    required this.email,
    required this.username,
    required this.password,
    required this.riderPhone,
    required this.riderName,
    required this.sex,
    required this.riderStatus,
    required this.credit,
    required this.wallet,
    required this.profileImage,
    required this.lat,
    required this.lng,
    required this.timeReg,
  });

  String riderId;
  String email;
  String username;
  String password;
  String riderPhone;
  String riderName;
  String sex;
  String riderStatus;
  String credit;
  String wallet;
  String profileImage;
  double lat;
  double lng;
  DateTime timeReg;

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
        riderId: json["rider_id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        riderPhone: json["rider_phone"],
        riderName: json["rider_name"],
        sex: json["sex"],
        riderStatus: json["rider_status"],
        credit: json["credit"],
        wallet: json["wallet"],
        profileImage: json["profile_image"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "rider_id": riderId,
        "email": email,
        "username": username,
        "password": password,
        "rider_phone": riderPhone,
        "rider_name": riderName,
        "sex": sex,
        "rider_status": riderStatus,
        "credit": credit,
        "wallet": wallet,
        "profile_image": profileImage,
        "lat": lat,
        "lng": lng,
        "time_reg": timeReg.toIso8601String(),
      };
}

class Riders with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  //------------------Variable---------------------
  List<Rider> _riders = [];
  Rider? _riderModel;

  TextEditingController _riderIdController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _riderPhoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _riderNameController = TextEditingController();
  TextEditingController _sexController = TextEditingController();
  TextEditingController _riderStatusController = TextEditingController();
  TextEditingController _creditController = TextEditingController();
  TextEditingController _walletController = TextEditingController();
  TextEditingController _profileImageController = TextEditingController();
  TextEditingController _amountMoneyController = TextEditingController();

  io.File? _file;

  //------------------GetterSetter---------------

  List<Rider> get riders => this._riders;

  set riders(List<Rider> value) => this._riders = value;

  Rider? get riderModel => this._riderModel;

  set riderModel(Rider? value) => this._riderModel = value;

  TextEditingController get emailController => this._emailController;

  set emailController(TextEditingController value) =>
      this._emailController = value;

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

  TextEditingController get profileImageController =>
      this._profileImageController;

  set profileImageController(TextEditingController value) =>
      this._profileImageController = value;

  get amountMoneyController => this._amountMoneyController;

  set amountMoneyController(value) => this._amountMoneyController = value;

  io.File? get file => this._file;

  set file(io.File? value) => this._file = value;

  //-------------------Method---------------------

  Future<String> updateCreditRider() async {
    double wallet = double.parse(_riderModel!.wallet) +
        double.parse(_creditController.text);
    double credit = double.parse(_riderModel!.credit) -
        double.parse(_creditController.text);
    var uri = Api.updateCreditWalletRider;
    var response = await http.post(Uri.parse(uri), body: {
      'rider_id': _riderModel!.riderId,
      'credit': credit.toString(),
      'wallet': wallet.toString(),
    });
    var results = jsonDecode(response.body);
    var result = results['result'];
    debugPrint(result.toString());
    if (results['msg'] == 'success') {
      await findById();
      return 'success';
    } else {
      return 'unsuccess';
    }
  }

  Future<void> updateWalletRider({required String wallet}) async {
    var uri = Api.updateRiderWallet;
    var response = await http.post(Uri.parse(uri), body: {
      'rider_id': _riderModel!.riderId,
      'wallet': wallet,
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    findById();
  }

  Future<void> updateStatus() async {
    // notifyListeners();
    var uri = Api.updateRiderStatus;
    var response = await http.post(Uri.parse(uri), body: {
      'rider_id': _riderModel!.riderId,
      'rider_status': _riderModel!.riderStatus,
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
  }

  Future<String> updateRider() async {
    if (_file != null) {
      await uploadImage();
    }
    var uri = Api.updateRider;
    var response = await http.post(Uri.parse(uri), body: {
      'rider_id': _riderIdController.text,
      'username': _usernameController.text,
      'password': _passwordController.text,
      'rider_phone': _riderPhoneController.text,
      'rider_name': _riderNameController.text,
      'sex': _sexController.text,
      'profile_image': _profileImageController.text
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findById();
    return results['msg'];
  }

  Future<void> getRiders() async {
    _riders.clear();
    var uri = Api.riders + "?find_rider_status=active";
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);

    var result = results['result'];
    print(result.toString());
    for (var item in result) {
      _riders.add(Rider.fromJson(item));
    }

    notifyListeners();
  }

  Future<bool> loginRider(
      {required String username, required String password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool login;
    var response = await http.post(Uri.parse(Api.loginRider), body: {
      'username': username,
      'password': password,
    });
    var results = jsonDecode(response.body);
    print(results.toString());
    var result = results['result'];
    if (result['msg'] == 'success') {
      login = true;
      sharedPreferences.setString("type", "rider");

      await findByUsername(username: result['username']);
    } else {
      login = false;
    }

    notifyListeners();
    return login;
  }

  Future<String> register() async {
    var response = await http.post(Uri.parse(Api.riders), body: {
      'email': _emailController.text,
      'username': _usernameController.text,
      'password': _passwordController.text,
      'rider_phone': _riderPhoneController.text,
      'rider_name': _riderNameController.text,
    });
    var results = jsonDecode(response.body);
    print(results.toString());
    var result = results;
    notifyListeners();
    return result['msg'];
  }

  Future<bool> findByUsername({required String username}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Api.riders + '?find_username=$username';
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    var result = results['result'];
    if (result.length > 0) {
      _riderModel = Rider.fromJson(result[0]);
      sharedPreferences.setString("rider_id", result[0]['rider_id'].toString());
      notifyListeners();
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  Future<void> findById() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? riderId = await sharedPreferences.getString("rider_id");
    var uri = Api.riders + '?findid=$riderId';
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    var result = results['result'];
    if (result.length > 0) {
      _riderModel = Rider.fromJson(result[0]);
    }
    debugPrint(result.toString());
    notifyListeners();
  }

  void logoutRider() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("type");
    notifyListeners();
  }

  Future<String> paymentCredit() async {
    double wallet = double.parse(_riderModel!.wallet) -
        double.parse(_amountMoneyController.text);
    double credit = double.parse(_riderModel!.credit) +
        double.parse(_amountMoneyController.text);
    var uri = Api.updateCreditWalletRider;
    var response = await http.post(Uri.parse(uri), body: {
      'rider_id': _riderModel!.riderId,
      'credit': credit.toString(),
      'wallet': wallet.toString(),
    });
    var results = jsonDecode(response.body);
    var result = results['result'];
    debugPrint(result.toString());
    if (results['msg'] == 'success') {
      await findById();
      return 'success';
    } else {
      return 'unsuccess';
    }
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
    await dio.Dio().post(Api.uploadRiderImage, data: formData).then((value) {
      debugPrint("Response ==>> $value");
      debugPrint("name image");
      debugPrint("$nameImage");
      debugPrint("name image");
      _profileImageController = TextEditingController(text: nameImage);
      // updateCustomer(ctx: context, profile_image: nameImage);
    });
  }

  Future<void> resetFile() async {
    _file = null;
    notifyListeners();
  }

  Future<void> setTextField() async {
    _riderIdController = TextEditingController(text: _riderModel!.riderId);
    _usernameController = TextEditingController(text: _riderModel!.username);
    _passwordController = TextEditingController(text: _riderModel!.password);
    _riderPhoneController =
        TextEditingController(text: _riderModel!.riderPhone);
    _riderNameController = TextEditingController(text: _riderModel!.riderName);
    _sexController = TextEditingController(text: _riderModel!.sex);
    _riderStatusController =
        TextEditingController(text: _riderModel!.riderStatus);
    _creditController = TextEditingController(text: _riderModel!.credit);
    _walletController = TextEditingController(text: _riderModel!.wallet);
    _profileImageController =
        TextEditingController(text: _riderModel!.profileImage);
    notifyListeners();
  }

  Future<bool> checkNullControll() async {
    bool checkNull = false;
    if (_riderIdController.text != '' &&
        _usernameController.text != '' &&
        _passwordController.text != '' &&
        _riderPhoneController.text != '' &&
        _riderNameController.text != '' &&
        _sexController.text != '' &&
        _riderStatusController.text != '' &&
        _creditController.text != '' &&
        _walletController.text != '') {
      checkNull = true;
    } else {
      checkNull = false;
    }
    return checkNull;
  }
}
