import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../utils/api.dart';

// To parse this JSON data, do
//
//     final withdrawRider = withdrawRiderFromJson(jsonString);

import 'dart:convert';

WithdrawRider withdrawRiderFromJson(String str) =>
    WithdrawRider.fromJson(json.decode(str));

String withdrawRiderToJson(WithdrawRider data) => json.encode(data.toJson());

class WithdrawRider {
  WithdrawRider({
    required this.wdRiderId,
    required this.riderId,
    required this.total,
    required this.bankName,
    required this.noBankAccount,
    required this.payStatus,
    required this.timeReg,
  });

  String wdRiderId;
  RiderId riderId;
  String total;
  String bankName;
  String noBankAccount;
  String payStatus;
  DateTime timeReg;

  factory WithdrawRider.fromJson(Map<String, dynamic> json) => WithdrawRider(
        wdRiderId: json["wd_rider_id"],
        riderId: RiderId.fromJson(json["rider_id"]),
        total: json["total"],
        bankName: json["bank_name"],
        noBankAccount: json["no_bank_account"],
        payStatus: json["pay_status"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "wd_rider_id": wdRiderId,
        "rider_id": riderId.toJson(),
        "total": total,
        "bank_name": bankName,
        "no_bank_account": noBankAccount,
        "pay_status": payStatus,
        "time_reg": timeReg.toIso8601String(),
      };
}

class RiderId {
  RiderId({
    required this.riderId,
    required this.username,
    required this.password,
    required this.riderName,
    required this.riderPhone,
    required this.profileImage,
    required this.wallet,
    required this.lat,
    required this.lng,
    required this.status,
    required this.timeReg,
  });

  String riderId;
  String username;
  String password;
  String riderName;
  String riderPhone;
  String profileImage;
  String wallet;
  double lat;
  double lng;
  String status;
  DateTime timeReg;

  factory RiderId.fromJson(Map<String, dynamic> json) => RiderId(
        riderId: json["rider_id"],
        username: json["username"],
        password: json["password"],
        riderName: json["rider_name"],
        riderPhone: json["rider_phone"],
        profileImage: json["profile_image"],
        wallet: json["wallet"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        status: json["status"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "rider_id": riderId,
        "username": username,
        "password": password,
        "rider_name": riderName,
        "rider_phone": riderPhone,
        "profile_image": profileImage,
        "wallet": wallet,
        "lat": lat,
        "lng": lng,
        "status": status,
        "time_reg": timeReg.toIso8601String(),
      };
}

class WithdrawRiders with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  //---------------variable---------------------------

  List<WithdrawRider> _withdrawRiders = [];

  TextEditingController _totalTextController = TextEditingController();
  TextEditingController _bankNameTextController = TextEditingController();
  TextEditingController _noBankAccountTextController = TextEditingController();

  io.File? _file;

  //---------------GetterSetter-----------------------

  get withdrawRiders => this._withdrawRiders;

  set withdrawRiders(value) => this._withdrawRiders = value;

  get totalTextController => this._totalTextController;

  set totalTextController(value) => this._totalTextController = value;

  get bankNameTextController => this._bankNameTextController;

  set bankNameTextController(value) => this._bankNameTextController = value;

  get noBankAccountTextController => this._noBankAccountTextController;

  set noBankAccountTextController(value) =>
      this._noBankAccountTextController = value;

  //---------------Method--------------------------------

  Future<void> getWithdraw() async {}

  Future<String> addWithdraw({required String riderId}) async {
    var uri = Api.withdrawRiders;
    debugPrint(
        "$riderId ${_totalTextController.text} ${_bankNameTextController.text} ${_noBankAccountTextController.text}");
    var response = await http.post(Uri.parse(uri), body: {
      'rider_id': riderId,
      'total': _totalTextController.text,
      'bank_name': _bankNameTextController.text,
      'no_bank_account': _noBankAccountTextController.text,
      'pay_status': '0',
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findWithdrawByRiderId(riderId: riderId);
    return results['msg'];
  }

  Future<void> findWithdrawByRiderId({required String riderId}) async {
    _withdrawRiders.clear();
    var uri = Api.withdrawRiders + '?find_rider_id=$riderId';
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    var result = results['result'];
    for (var item in result) {
      _withdrawRiders.add(WithdrawRider.fromJson(item));
    }
    notifyListeners();
  }

  Future<void> updateWithdraw() async {}

  Future<String> updateWithdrawStatus(
      {required String wdRiderId, required String payStatus}) async {
    var uri = Api.updateWithdrawRiderStatus;
    var response = await http.post(Uri.parse(uri), body: {
      'wd_rider_id': wdRiderId,
      'pay_status': payStatus,
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    return results['msg'];
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
    final DateFormat formatter = DateFormat('MMddyyyy');
    String createDate = formatter.format(DateTime.now());
    String nameImage = 'withdraw_rider$i' + '_' + '$createDate.jpg';
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
  }
}
