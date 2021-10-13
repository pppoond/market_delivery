// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:market_delivery/model/address_model.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart' as dio;

import '../utils/api.dart';

class Customer {
  Customer({
    required this.customerId,
    required this.username,
    this.password = "",
    required this.customerName,
    required this.customerPhone,
    this.profileImage = "",
    required this.sex,
    required this.timeReg,
  });

  final int customerId;
  final String username;
  final String password;
  final String customerName;
  final String customerPhone;
  final String profileImage;
  final String sex;
  final DateTime timeReg;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["customer_id"],
        username: json["username"],
        password: json["password"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        profileImage: json['profile_image'],
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
  //--------------------------variable----------------------

  List<AddressModel> _listAddressModel = [];

  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _customerNameTextController = TextEditingController();
  TextEditingController _customerPhoneTextController = TextEditingController();
  TextEditingController _sexTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();

  Customer? _customerModel;
  bool? _loginStatus;
  String? _customerId;

  double? _lat;
  double? _lng;

  Completer<GoogleMapController> _controller = Completer();

  //--------------------------GetterSetter-------------------------

  List<AddressModel> get listAddressModel => this._listAddressModel;

  set listAddressModel(List<AddressModel> value) =>
      this._listAddressModel = value;

  TextEditingController get usernameTextController =>
      this._usernameTextController;

  set usernameTextController(TextEditingController value) =>
      this._usernameTextController = value;

  get passwordTextController => this._passwordTextController;

  set passwordTextController(value) => this._passwordTextController = value;

  get customerNameTextController => this._customerNameTextController;

  set customerNameTextController(value) =>
      this._customerNameTextController = value;

  get customerPhoneTextController => this._customerPhoneTextController;

  set customerPhoneTextController(value) =>
      this._customerPhoneTextController = value;

  get sexTextController => this._sexTextController;

  set sexTextController(value) => this._sexTextController = value;

  get addressTextController => this._addressTextController;

  set addressTextController(value) => this._addressTextController = value;

  double? get lat => this._lat;

  set lat(double? value) => this._lat = value;

  get lng => this._lng;

  set lng(value) => this._lng = value;

  Completer<GoogleMapController> get controller => this._controller;

  set controller(Completer<GoogleMapController> value) =>
      this._controller = value;

  Customer? get customerModel => _customerModel;
  bool? get loginStatus => _loginStatus;
  String? get customerId => _customerId;

  //---------------------------method-----------------------------------

  Future<bool> findByUsernameCheckNull({required String username}) async {
    bool _usernameNull;
    var response =
        await http.get(Uri.parse("${Api.customer}?find_username=${username}"));
    var results = jsonDecode(response.body);
    // print(results);
    var result = results['result']!;
    if (result.isEmpty) {
      _usernameNull = true;
    } else {
      _usernameNull = false;
    }
    // print("check before return");
    // print(_usernameNull);
    // print("c____________________");
    return _usernameNull;
  }

  void findCustomer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? customerId = await sharedPreferences.getString('customerId');
    if (customerId != null) {
      var response =
          await http.get(Uri.parse("${Api.customer}?findid=${customerId}"));
      var results = jsonDecode(response.body);
      // print("reeeeeeeeeeeeeeeeeeeeeeeeee");
      // print(results['result'][0]['customer_id']);
      var result = results['result'][0];
      // String profileImage;
      // String sex;
      // String customerPhone;
      // int customerIdLoad = int.parse(result['customer_id']);
      // if (result['profile_image'] != null &&
      //     result['sex'] != null &&
      //     result['customer_phone'] != null) {
      //   profileImage = result['profile_image'];
      //   sex = result['sex'];
      //   customerPhone = result['customer_phone'];
      // } else {
      //   profileImage = "";
      //   sex = "";
      //   customerPhone = "";
      // }
      _customerModel = Customer(
        customerId: result['customer_id'],
        customerName: result['customer_name'],
        customerPhone:
            result['customer_phone'] != null ? result['customer_phone'] : "",
        password: result['password'],
        profileImage:
            result['profile_image'] != null ? result['profile_image'] : "",
        sex: result['sex'] != null ? result['sex'] : "",
        timeReg: DateTime.parse(result['time_reg']),
        username: result['username'],
      );

      this._customerNameTextController =
          TextEditingController(text: customerModel!.customerName);
    }
    findAddress();
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
    _customerModel = null;
    _customerId = null;
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

  Future<dynamic> updateCustomer({
    required String profileImage,
    required int customerId,
    required String username,
    required String password,
    required String customerName,
    required String customerPhone,
    required int sex,
  }) async {
    var results;
    print("update Customer");
    var formData = dio.FormData.fromMap({
      "customer_id": customerId,
      "username": username,
      "password": password,
      "customer_name": customerName,
      "customer_phone": customerPhone,
      "sex": sex,
      "profile_image": profileImage,
    });
    try {
      results = await dio.Dio().post(Api.updateCustomer, data: formData);
    } catch (e) {
      print(e);
    }
    return results;
  }

  Future<dynamic> addAddress(
      // {
      // required String customerId,
      // required String address,
      // required String lat,
      // required String lng,
      // required String addr_status,
      // }
      ) async {
    print("Add Address");
    try {
      var results = await http.post(Uri.parse(Api.addCustomerAddress), body: {
        'customer_id': customerModel!.customerId.toString(),
        'address': _addressTextController.text.toString(),
        'lat': _lat.toString(),
        'lng': _lng.toString(),
        'addr_status': 0.toString(),
      });
      print("Add Address");
      var result = jsonDecode(results.body);
      print(result.toString());
      print("______________");
      await findAddress();
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> showConfirmAlert({required BuildContext context}) async {
    print(_addressTextController.text);
    return CoolAlert.show(
      context: context,
      title: "ต้องการบันทึกหรือไม่",
      type: CoolAlertType.confirm,
      confirmBtnText: "ยืนยัน",
      onConfirmBtnTap: () {},
    );
  }

  Future<Null> findLatLng() async {
    await permissionHandle();
    LocationData? locationData = await findLocationData();
    _lat = locationData!.latitude;
    _lng = locationData.longitude;
    print('lat : $lat  lng : $lng');
    notifyListeners();
  }

  Future<LocationData?> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Future<Null> setLatLng(LatLng latLng) async {
    _lat = latLng.latitude;
    _lng = latLng.longitude;
    // moveCamera();
  }

  Future<void> permissionHandle() async {
    var location = await Permission.location;
    print(location.status);
    if (location.status == location.status.isDenied) {
      location.request();
    }
  }

  Future<void> moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(_lat!, _lng!),
      zoom: 14,
    )));
    notifyListeners();
  }

  Future<Null> findAddress() async {
    _listAddressModel.clear();
    if (customerModel?.customerId != null) {
      await http
          .get(Uri.parse(
              Api.addresses + "?find_customer_id=${customerModel!.customerId}"))
          .then((value) {
        var results = jsonDecode(value.body);
        // print(results['result']);
        for (var item in results['result']) {
          _listAddressModel.add(AddressModel(
            addressId: item['address_id'],
            customerId: item['customer_id'],
            address: item['address'],
            lat: item['lat'],
            lng: item['lng'],
            addrStatus: item['addr_status'],
            timeReg: DateTime.parse(item['time_reg']),
          ));
        }
      });
    }

    notifyListeners();
  }

  Future<dynamic> updateAddressStatus({
    required String addressId,
    required String addrStatus,
  }) async {
    try {
      for (var item in _listAddressModel) {
        var result = await http.post(Uri.parse(Api.updateAddrStatus), body: {
          'address_id': item.addressId.toString(),
          'addr_status': "0"
        });
        print('Loop item ${item.addressId}');

        print(jsonDecode(result.body).toString());
        print('Loop item ${item.addressId}');
      }
      var results = await http.post(Uri.parse(Api.updateAddrStatus), body: {
        'address_id': addressId.toString(),
        'addr_status': addrStatus.toString()
      });
      var result = jsonDecode(results.body);
      // print(result.toString());
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<void> onRefreshWidget() async {
    await findAddress();
  }

  Future<dynamic> deleteAddress({required String addressId}) async {
    try {
      var results =
          await http.get(Uri.parse(Api.addresses + "?delete_by_id=$addressId"));
      var result = jsonDecode(results.body);
      findAddress();
      return result;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();
    try {
      var status = await Permission.location.status;
      if (status.isDenied) {
        await Permission.location.request();
      }
      LocationData getLocation = await location.getLocation();
      _lat = getLocation.latitude;
      _lng = getLocation.longitude;
      notifyListeners();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
    }
  }
}
