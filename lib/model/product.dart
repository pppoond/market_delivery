import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:market_delivery/model/store.dart';
import 'package:provider/provider.dart';

import '../../utils/api.dart';

import './product_image.dart';

class Product {
  Product({
    required this.productId,
    required this.storeId,
    required this.categoryId,
    required this.productName,
    this.productDetail = "",
    this.status = "0",
    required this.timeReg,
    this.productImages,
  });

  String productId;
  String storeId;
  String categoryId;
  String productName;
  String productDetail;
  String status;
  DateTime timeReg;
  List<ProductImage>? productImages;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        storeId: json["store_id"],
        categoryId: json["category_id"],
        productName: json["product_name"],
        productDetail: json["product_detail"],
        status: json["status"],
        timeReg: DateTime.parse(json["time_reg"]),
        productImages: List<ProductImage>.from(
            json["product_images"].map((x) => ProductImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "store_id": storeId,
        "category_id": categoryId,
        "product_name": productName,
        "product_detail": productDetail,
        "status": status,
        "time_reg": timeReg.toIso8601String(),
        "product_images":
            List<dynamic>.from(productImages!.map((x) => x.toJson())),
      };
}

class Products with ChangeNotifier {
  //---------------variable---------------------

  List<Product>? _products = [];

  //---------------GetterSetter----------------

  get products => this._products;

  get productLength => this._products!.length;

  set products(value) => this._products = value;

  //----------------method--------------------

  Future<void> getProduct({required String storeId}) async {
    _products!.clear();
    await http
        .get(Uri.parse(Api.products + "?find_store_id=$storeId"))
        .then((value) {
      var results = jsonDecode(value.body);
      var result = results['result'];
      for (var item in result) {
        _products!.add(Product.fromJson(item));
      }
      print(_products!.length);
      notifyListeners();
    });
  }

  Future<dynamic> addProduct() async {}
  Future<dynamic> updateProduct() async {}
  Future<dynamic> deleteProduct({required String productId}) async {}
  Future<dynamic> findById({required String productId}) async {
    Product product;
    var response =
        await http.get(Uri.parse(Api.products + "?findid=$productId"));
    var results = jsonDecode(response.body);
    var result = results['result'];
    product = Product.fromJson(result[0]);
    notifyListeners();
    return product;
  }
}
