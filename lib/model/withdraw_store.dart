import 'dart:convert';
import 'dart:math';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../utils/api.dart';

// To parse this JSON data, do
//
//     final withdrawStore = withdrawStoreFromJson(jsonString);

import 'dart:convert';

WithdrawStore withdrawStoreFromJson(String str) =>
    WithdrawStore.fromJson(json.decode(str));

String withdrawStoreToJson(WithdrawStore data) => json.encode(data.toJson());

class WithdrawStore {
  WithdrawStore({
    required this.wdStoreId,
    required this.storeId,
    required this.total,
    required this.bankName,
    required this.noBankAccount,
    required this.payStatus,
    required this.timeReg,
  });

  String wdStoreId;
  StoreId storeId;
  String total;
  String bankName;
  String noBankAccount;
  String payStatus;
  DateTime timeReg;

  factory WithdrawStore.fromJson(Map<String, dynamic> json) => WithdrawStore(
        wdStoreId: json["wd_store_id"],
        storeId: StoreId.fromJson(json["store_id"]),
        total: json["total"],
        bankName: json["bank_name"],
        noBankAccount: json["no_bank_account"],
        payStatus: json["pay_status"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "wd_store_id": wdStoreId,
        "store_id": storeId.toJson(),
        "total": total,
        "bank_name": bankName,
        "no_bank_account": noBankAccount,
        "pay_status": payStatus,
        "time_reg": timeReg.toIso8601String(),
      };
}

class StoreId {
  StoreId({
    required this.storeId,
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
  String username;
  String password;
  String storeName;
  String storePhone;
  String profileImage;
  String wallet;
  double lat;
  double lng;
  String status;
  DateTime timeReg;

  factory StoreId.fromJson(Map<String, dynamic> json) => StoreId(
        storeId: json["store_id"],
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

class WithdrawStores with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  //----------------variable----------------

  List<WithdrawStore> _withdrawStores = [];

  TextEditingController _amountMoneyController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _noBankAccountController = TextEditingController();
  TextEditingController _sliptController = TextEditingController();

  io.File? _file;

  //----------------GetterSetter------------

  List<WithdrawStore> get withdrawStores => this._withdrawStores;

  set withdrawStores(List<WithdrawStore> value) => this._withdrawStores = value;

  get amountMoneyController => this._amountMoneyController;

  set amountMoneyController(value) => this._amountMoneyController = value;

  get bankNameController => this._bankNameController;

  set bankNameController(value) => this._bankNameController = value;

  get noBankAccountController => this._noBankAccountController;

  set noBankAccountController(value) => this._noBankAccountController = value;

  get sliptController => this._sliptController;

  set sliptController(value) => this._sliptController = value;

  //----------------Method------------------

  Future<String> withdrawMoney({required String storeId}) async {
    var uri = Api.withdrawStore;
    debugPrint(
        "$storeId ${_amountMoneyController.text} ${_bankNameController.text} ${_noBankAccountController.text}");
    var response = await http.post(Uri.parse(uri), body: {
      'store_id': storeId,
      'total': _amountMoneyController.text,
      'bank_name': _bankNameController.text,
      'no_bank_account': _noBankAccountController.text,
      'pay_status': '0',
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await findWithdrawByStoreId(storeId: storeId);
    return results['msg'];
  }

  Future<void> findWithdrawByStoreId({required String storeId}) async {
    _withdrawStores.clear();
    var uri = Api.withdrawStore + '?find_store_id=$storeId';
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    var result = results['result'];
    for (var item in result) {
      _withdrawStores.add(WithdrawStore.fromJson(item));
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
    String nameImage = 'slipt_store$i' + '_' + '$createDate.jpg';

    Map<String, dynamic> map = Map();
    map['file'] =
        await dio.MultipartFile.fromFile(_file!.path, filename: nameImage);

    dio.FormData formData = dio.FormData.fromMap(map);
    await dio.Dio().post(Api.uploadStoreImage, data: formData).then((value) {
      debugPrint("Response ==>> $value");
      debugPrint("name image");
      debugPrint("$nameImage");
      debugPrint("name image");
      _sliptController = TextEditingController(text: nameImage);
      // updateCustomer(ctx: context, profile_image: nameImage);
    });
  }
}
