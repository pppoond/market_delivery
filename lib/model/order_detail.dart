import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';
// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

import 'package:market_delivery/utils/api.dart';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  OrderDetail({
    required this.orderDetailId,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.timeReg,
  });

  String orderDetailId;
  OrderId orderId;
  ProductId productId;
  String quantity;
  DateTime timeReg;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderDetailId: json["order_detail_id"],
        orderId: OrderId.fromJson(json["order_id"]),
        productId: ProductId.fromJson(json["product_id"]),
        quantity: json["quantity"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "order_detail_id": orderDetailId,
        "order_id": orderId.toJson(),
        "product_id": productId.toJson(),
        "quantity": quantity,
        "time_reg": timeReg.toIso8601String(),
      };
}

class OrderId {
  OrderId({
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

  factory OrderId.fromJson(Map<String, dynamic> json) => OrderId(
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
        profileImage: json["profile_image"],
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
        "profile_image": profileImage,
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

class ProductId {
  ProductId({
    required this.productId,
    required this.storeId,
    required this.categoryId,
    required this.productName,
    this.productDetail = "",
    this.status = "0",
    this.price = "0",
    this.unit = "",
    required this.timeReg,
  });

  String productId;
  String storeId;
  String categoryId;
  String productName;
  String productDetail;
  String status;
  String price;
  String unit;
  DateTime timeReg;

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        productId: json["product_id"],
        storeId: json["store_id"],
        categoryId: json["category_id"],
        productName: json["product_name"],
        productDetail: json["product_detail"],
        status: json["status"],
        price: json['price'],
        unit: json['unit'],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "store_id": storeId,
        "category_id": categoryId,
        "product_name": productName,
        "product_detail": productDetail,
        "status": status,
        "price": price,
        "unit": unit,
        "time_reg": timeReg.toIso8601String(),
      };
}

class OrderDetails with ChangeNotifier {
  //-----------------variable--------------------

  List<OrderDetail> _orderDetailList = [];

  //-----------------GetterSetter----------------

  List<OrderDetail> get orderDetailList => this._orderDetailList;

  set orderDetailList(value) => this._orderDetailList = value;

  double get totalMoney {
    double total = 0.0;
    _orderDetailList.forEach((element) {
      total += double.parse(element.productId.price) *
          double.parse(element.quantity);
    });
    return total;
  }

  double get totalPayment {
    double total = 0.0;
    _orderDetailList.forEach((element) {
      total += double.parse(element.productId.price) *
          double.parse(element.quantity);
    });
    total += 15;
    return total;
  }

  //----------------Method-----------------------

  Future<void> getOrderDetailByOrderId({required String orderId}) async {
    _orderDetailList.clear();
    String uri = Api.orderDetails + "?order_id=$orderId";
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    for (var item in result) {
      _orderDetailList.add(OrderDetail.fromJson(item));
    }
    notifyListeners();
  }

  Future<void> addOrderDetail({
    required String orderId,
    required String productId,
    required String quantity,
  }) async {
    String uri = Api.orderDetails;
    var response = await http.post(Uri.parse(uri), body: {
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
    });
    var results = jsonDecode(response.body);
    debugPrint(results['msg']);
  }

  Future<void> resetStateOrderDetails() async {
    _orderDetailList.clear();
    notifyListeners();
  }
}
