import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:market_delivery/utils/api.dart';

// To parse this JSON data, do
//
//     final paymentRider = paymentRiderFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final paymentRider = paymentRiderFromJson(jsonString);

import 'dart:convert';

PaymentRider paymentRiderFromJson(String str) =>
    PaymentRider.fromJson(json.decode(str));

String paymentRiderToJson(PaymentRider data) => json.encode(data.toJson());

class PaymentRider {
  PaymentRider({
    required this.payRiderId,
    required this.riderId,
    required this.total,
    required this.bankName,
    required this.noBankAccount,
    required this.payStatus,
    required this.timeReg,
  });

  String payRiderId;
  RiderId riderId;
  String total;
  String bankName;
  String noBankAccount;
  String payStatus;
  DateTime timeReg;

  factory PaymentRider.fromJson(Map<String, dynamic> json) => PaymentRider(
        payRiderId: json["pay_rider_id"],
        riderId: RiderId.fromJson(json["rider_id"]),
        total: json["total"],
        bankName: json["bank_name"],
        noBankAccount: json["no_bank_account"],
        payStatus: json["pay_status"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "pay_rider_id": payRiderId,
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

class PaymentRiders with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  //--------------variable-----------------------------

  TextEditingController _payRiderIdController = TextEditingController();
  TextEditingController _riderIdController = TextEditingController();
  TextEditingController _totalController = TextEditingController();
  TextEditingController _slipController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _noBankAccountController = TextEditingController();
  TextEditingController _payStatusController = TextEditingController();

  List<PaymentRider> _paymentRiderList = [];

  io.File? _file;

  //------------GetterSetter---------------------

  get payRiderIdController => this._payRiderIdController;

  set payRiderIdController(value) => this._payRiderIdController = value;

  get riderIdController => this._riderIdController;

  set riderIdController(value) => this._riderIdController = value;

  get totalController => this._totalController;

  set totalController(value) => this._totalController = value;

  get slipController => this._slipController;

  set slipController(value) => this._slipController = value;

  get bankNameController => this._bankNameController;

  set bankNameController(value) => this._bankNameController = value;

  get accountNameController => this._accountNameController;

  set accountNameController(value) => this._accountNameController = value;

  get noBankAccountController => this._noBankAccountController;

  set noBankAccountController(value) => this._noBankAccountController = value;

  get payStatusController => this._payStatusController;

  set payStatusController(value) => this._payStatusController = value;

  get paymentRiderList => this._paymentRiderList;

  set paymentRiderList(value) => this._paymentRiderList = value;

  get file => this._file;

  set file(value) => this._file = value;

  //------------Method---------------------------

  Future<void> getPayment() async {}

  Future<String> addPayment({required String riderId}) async {
    if (_file != null) {
      await uploadImage();
    }
    var uri = Api.paymentRiders;
    var response = await http.post(Uri.parse(uri), body: {
      'rider_id': riderId,
      'total': _totalController.text,
      'slip': _slipController.text,
      'bank_name': _bankNameController.text,
      'account_name': _accountNameController.text,
      'no_bank_account': _noBankAccountController.text,
      'pay_status': '0',
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findPaymentByRiderId(riderId: riderId);
    return results['msg'];
  }

  Future<void> findPaymentByRiderId({required String riderId}) async {
    _paymentRiderList.clear();
    var uri = Api.paymentRiders + '?rider_id=$riderId';
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    var result = results['result'];
    for (var item in result) {
      _paymentRiderList.add(PaymentRider.fromJson(item));
    }
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
    String nameImage = 'slip_rider$i' + '_' + '$createDate.jpg';

    Map<String, dynamic> map = Map();
    map['file'] =
        await dio.MultipartFile.fromFile(_file!.path, filename: nameImage);

    dio.FormData formData = dio.FormData.fromMap(map);
    await dio.Dio()
        .post(Api.uploadSlipPaymentRider, data: formData)
        .then((value) {
      debugPrint("Response ==>> $value");
      debugPrint("name image");
      debugPrint("$nameImage");
      debugPrint("name image");
      _slipController = TextEditingController(text: nameImage);
      // updateCustomer(ctx: context, profile_image: nameImage);
    });
  }

  Future<void> resetFile() async {
    _file = null;
    notifyListeners();
  }
}
