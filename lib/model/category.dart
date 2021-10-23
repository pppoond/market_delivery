// To parse required this. JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:market_delivery/utils/api.dart';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    required this.categoryId,
    required this.categoryName,
    required this.timeReg,
  });

  String categoryId;
  String categoryName;
  DateTime timeReg;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "time_reg": timeReg.toIso8601String(),
      };
}

class Categorys with ChangeNotifier {
  //--------------variable---------------

  List<Category> _listCategory = [];

  //--------------GetterSetter--------------

  List<Category> get listCategory => this._listCategory;

  set listCategory(value) => this._listCategory = value;

  //-------------Method-----------------

  Future<void> getCategory() async {
    _listCategory.clear();
    String uri = Api.categorys;
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    for (var item in result) {
      _listCategory.add(Category.fromJson(item));
    }
    notifyListeners();
  }
}
