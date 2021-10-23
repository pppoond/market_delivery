import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './store.dart';
import './customer.dart';
import './rider.dart';

import '../utils/api.dart';

// To parse required required required this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

// To parse required required this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

// To parse required this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.orderId,
    required this.storeId,
    required this.riderId,
    required this.customerId,
    required this.addressId,
    required this.orderDate,
    required this.total,
    required this.cashMethod,
    required this.status,
    required this.timeReg,
  });

  String orderId;
  StoreId storeId;
  RiderId riderId;
  CustomerId customerId;
  AddressId addressId;
  DateTime orderDate;
  String total;
  String cashMethod;
  String status;
  DateTime timeReg;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        storeId: StoreId.fromJson(json["store_id"]),
        riderId: RiderId.fromJson(json["rider_id"]),
        customerId: CustomerId.fromJson(json["customer_id"]),
        addressId: AddressId.fromJson(json["address_id"]),
        orderDate: DateTime.parse(json["order_date"]),
        total: json["total"],
        cashMethod: json["cash_method"],
        status: json["status"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "store_id": storeId.toJson(),
        "rider_id": riderId.toJson(),
        "customer_id": customerId.toJson(),
        "address_id": addressId.toJson(),
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "total": total,
        "cash_method": cashMethod,
        "status": status,
        "time_reg": timeReg.toIso8601String(),
      };
}

class AddressId {
  AddressId({
    required this.addressId,
    required this.customerId,
    required this.address,
    required this.lat,
    required this.lng,
    required this.addrStatus,
    required this.timeReg,
  });

  String addressId;
  String customerId;
  String address;
  double lat;
  double lng;
  String addrStatus;
  DateTime timeReg;

  factory AddressId.fromJson(Map<String, dynamic> json) => AddressId(
        addressId: json["address_id"],
        customerId: json["customer_id"],
        address: json["address"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        addrStatus: json["addr_status"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "customer_id": customerId,
        "address": address,
        "lat": lat,
        "lng": lng,
        "addr_status": addrStatus,
        "time_reg": timeReg.toIso8601String(),
      };
}

class CustomerId {
  CustomerId({
    required this.customerId,
    required this.username,
    required this.password,
    required this.customerName,
    required this.customerPhone,
    required this.profileImage,
    required this.sex,
    required this.timeReg,
  });

  String customerId;
  String username;
  String password;
  String customerName;
  String customerPhone;
  String profileImage;
  String sex;
  DateTime timeReg;

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
        customerId: json["customer_id"],
        username: json["username"],
        password: json["password"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        profileImage: json["profile_image"],
        sex: json["sex"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "username": username,
        "password": password,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "profile_image": profileImage,
        "sex": sex,
        "time_reg": timeReg.toIso8601String(),
      };
}

class RiderId {
  RiderId({
    required this.riderId,
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

  factory RiderId.fromJson(Map<String, dynamic> json) => RiderId(
        riderId: json["rider_id"],
        username: json["username"],
        password: json["password"],
        riderPhone: json["rider_phone"],
        riderName: json["rider_name"],
        sex: json["sex"],
        riderStatus: json["rider_status"],
        credit: json["credit"],
        wallet: json["wallet"],
        profileImage:
            json["profile_image"] == null ? '' : json["profile_image"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "rider_id": riderId,
        "username": username,
        "password": password,
        "rider_phone": riderPhone,
        "rider_name": riderName,
        "sex": sex,
        "rider_status": riderStatus,
        "credit": credit,
        "wallet": wallet,
        "profile_image": profileImage == null ? '' : profileImage,
        "lat": lat,
        "lng": lng,
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
  dynamic profileImage;
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

class Orders with ChangeNotifier {
  //------------variable-----------------------

  Order? _order;
  List<Order> _orderByStoreId = [];
  List<Order> _orderByCustomerId = [];
  List<Order> _orderByStoreDate = [];

  //------------GetterSetter-------------------

  List<Order> get orderByStoreDate => this._orderByStoreDate;

  set orderByStoreDate(value) => this._orderByStoreDate = value;

  int get countOrderStoreDateTodayS4 {
    int counter = 0;
    for (var item in _orderByStoreDate) {
      if (item.status == '4') {
        counter++;
      }
    }

    return counter;
  }

  List<Order> get countOrderStoreStatus0 {
    var listOrderByStatusOne =
        _orderByStoreId.where((element) => element.status == '0').toList();

    return [...listOrderByStatusOne];
  }

  List<Order> get countOrderStoreStatus2 {
    var listOrderByStatusOne =
        _orderByStoreId.where((element) => element.status == '2').toList();

    return [...listOrderByStatusOne];
  }

  List<Order> get countOrderStoreStatus3 {
    var listOrderByStatusOne =
        _orderByStoreId.where((element) => element.status == '3').toList();

    return [...listOrderByStatusOne];
  }

  List<Order> get countOrderStoreStatus4 {
    var listOrderByStatusOne =
        _orderByStoreId.where((element) => element.status == '4').toList();

    return [...listOrderByStatusOne];
  }

  List<Order> get countOrderStoreStatus5 {
    var listOrderByStatusOne =
        _orderByStoreId.where((element) => element.status == '5').toList();

    return [...listOrderByStatusOne];
  }

  Order? get order => this._order;

  set order(Order? value) => this._order = value;

  List<Order> get orderByStoreId => this._orderByStoreId;

  set orderByStoreId(List<Order> value) => this._orderByStoreId = value;

  List<Order> get orderByCustomerId => this._orderByCustomerId;

  set orderByCustomerId(List<Order> value) => this._orderByCustomerId = value;

  //---------------method--------------------------

  Future<void> getOrder() async {
    print("Get Orders");
  }

  Future<String> addOrder(
      {required String storeId,
      required String riderId,
      required String customerId,
      required String addressId,
      required String orderDate,
      required String cashMethod,
      required String total}) async {
    debugPrint('Add Order');
    debugPrint('$storeId $riderId $customerId $orderDate $cashMethod $total');
    var uri = Api.orders;
    var response = await http.post(Uri.parse(uri), body: {
      'store_id': storeId,
      'rider_id': riderId,
      'customer_id': customerId,
      'address_id': addressId,
      'order_date': orderDate,
      'total': total,
      'cash_method': cashMethod,
      'order_status': "0"
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    return results['result']['order_id'];
  }

  Future<void> getOrderByStoreId() async {
    _orderByStoreId.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? storeId = await sharedPreferences.getString('store_id');
    String uri = Api.orders + "?store_id=$storeId";
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    for (var item in result) {
      _orderByStoreId.add(Order.fromJson(item));
    }
    notifyListeners();
  }

  Future<void> getOrderByStoreDateToday() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    _orderByStoreDate.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? storeId = await sharedPreferences.getString('store_id');
    String uri = Api.orders + "?store_id=$storeId&order_date=$formattedDate";
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    for (var item in result) {
      _orderByStoreDate.add(Order.fromJson(item));
    }
    notifyListeners();
  }

  Future<void> getOrderByCustomerId() async {
    _orderByCustomerId.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? customerId = await sharedPreferences.getString('customerId');
    String uri = Api.orders + "?customer_id=$customerId";
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    for (var item in result) {
      _orderByCustomerId.add(Order.fromJson(item));
    }
    notifyListeners();
  }

  Future<void> updateOrderStatus(
      {required String orderId, required String orderStatus}) async {
    String uri = Api.updateOrderStatus;
    var response = await http.post(Uri.parse(uri), body: {
      'order_id': orderId,
      'order_status': orderStatus,
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    notifyListeners();
  }

  Future<void> resetStateOrder() async {
    _orderByCustomerId.clear();
    _orderByStoreId.clear();
    _order = null;
    notifyListeners();
  }
}
