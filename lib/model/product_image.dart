import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';

import 'package:dio/dio.dart' as dio;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../utils/api.dart';

class ProductImage {
  ProductImage({
    required this.proImgId,
    required this.productId,
    this.proImgAddr = "",
    required this.timeReg,
  });

  String proImgId;
  String productId;
  String proImgAddr;
  DateTime timeReg;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        proImgId: json["pro_img_id"],
        productId: json["product_id"],
        proImgAddr: json["pro_img_addr"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "pro_img_id": proImgId,
        "product_id": productId,
        "pro_img_addr": proImgAddr,
        "time_reg": timeReg.toIso8601String(),
      };
}

class ProductImages with ChangeNotifier {
  //---------------------variable----------------

  List<ProductImage> _productImages = [];

  io.File? _file;
  List<io.File>? _listFile;

  final ImagePicker _picker = ImagePicker();

  //--------------------GetterSetter--------------

  List<ProductImage> get productImages => this._productImages;

  set productImages(List<ProductImage> value) => this._productImages = value;

  io.File? get file => this._file;

  set file(io.File? value) => this._file = value;

  //--------------------method--------------------

  Future<void> getProductImage({required String storeId}) async {
    _productImages.clear();
    await http
        .get(Uri.parse(Api.products + "?find_store_id=$storeId"))
        .then((value) {
      var results = jsonDecode(value.body);
      var result = results['result'];
      for (var item in result) {
        _productImages.add(ProductImage.fromJson(item));
      }
      print(_productImages.length);
      notifyListeners();
    });
  }

  Future<dynamic> addProductImage(
      {required String productId, required String proImgAddr}) async {
    var uri = Api.productImages;
    var response = await http.post(Uri.parse(uri), body: {
      "product_id": productId,
      "pro_img_addr": proImgAddr,
    });
    var results = jsonDecode(response.body);
    // var result = results['result'];
    return results;
  }

  Future<dynamic> updateProductImage(
      {required String proImgId, required String proImgAddr}) async {
    var uri = Api.productImages;
    var response = await http.post(Uri.parse(uri));
    var results = jsonDecode(response.body);
    // var result = results['result'];
  }

  Future<dynamic> deleteProductImage({required String proImgId}) async {
    var uri = Api.productImages;
    var response = await http.get(Uri.parse(uri + "?delete=$proImgId"));
    var results = jsonDecode(response.body);
    notifyListeners();
    return results;
  }

  Future<ProductImage> findById({required String proImgId}) async {
    ProductImage product;
    var response =
        await http.get(Uri.parse(Api.productImages + "?findid=$proImgId"));
    var results = jsonDecode(response.body);
    var result = results['result'];
    if (result != null) {
      print(result.toString());
      product = ProductImage.fromJson(result[0]);
      notifyListeners();
      return product;
    } else {
      return null!;
    }
  }

  Future<void> chooseImage(BuildContext ctx, ImageSource imageSource) async {
    try {
      var object = await _picker.pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      _file = io.File(object!.path);
      // _listFile!.add(io.File(object!.path));
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<dynamic> uploadImage(
      {required BuildContext context, required String productId}) async {
    Random random = Random();
    int i = random.nextInt(1000000);
    final DateFormat formatter = DateFormat('MMddyyyy');
    String createDate = formatter.format(DateTime.now());
    String nameImage = 'product_image$i' + '_' + '$createDate.jpg';
    // print(nameImage);
    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await dio.MultipartFile.fromFile(_file!.path, filename: nameImage);

      dio.FormData formData = dio.FormData.fromMap(map);
      var response =
          await dio.Dio().post(Api.uploadProductImage, data: formData);
      print(response.data);
      var response_add =
          await addProductImage(productId: productId, proImgAddr: nameImage);
      print(response_add);
      return response_add;
    } catch (e) {
      print(e);
    }
  }

  Future<void> resetFile() async {
    _file = null;
    notifyListeners();
  }
}
