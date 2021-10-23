// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'package:dio/dio.dart' as dio;

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.postId,
    required this.storeId,
    required this.message,
    required this.images,
    required this.timeReg,
  });

  String postId;
  StoreId storeId;
  String message;
  List<String> images;
  DateTime timeReg;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postId: json["post_id"],
        storeId: StoreId.fromJson(json["store_id"]),
        message: json["message"],
        images: List<String>.from(json["images"].map((x) => x)),
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "store_id": storeId.toJson(),
        "message": message,
        "images": List<dynamic>.from(images.map((x) => x)),
        "time_reg": timeReg.toIso8601String(),
      };
}

class StoreId {
  StoreId({
    required this.storeId,
    required this.email,
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
  String email;
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
        email: json["email"],
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
        "email": email,
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

class Posts with ChangeNotifier {
  //-------------------variable----------------------

  List<Post> _listPostStore = [];
  List<Post> _listPost = [];

  List<io.File> _listFile = [];

  final ImagePicker _picker = ImagePicker();

  TextEditingController _storeIdController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  List<String> _images = [];

  //--------------------GetterSetter----------------------

  List<io.File> get listFile => this._listFile;

  set listFile(List<io.File> value) => this._listFile = value;

  List<Post> get listPostStore => this._listPostStore;

  set listPostStore(value) => this._listPostStore = value;

  List<Post> get listPost => this._listPost;

  set listPost(value) => this._listPost = value;

  get storeIdController => this._storeIdController;

  set storeIdController(value) => this._storeIdController = value;

  get messageController => this._messageController;

  set messageController(value) => this._messageController = value;

  //----------------------method----------------------

  Future<void> getPostByStoreId() async {
    _listPostStore.clear();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? storeId = await sharedPreferences.getString('store_id');
    String uri = Api.posts + "?store_id=$storeId";
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    for (var item in result) {
      _listPostStore.add(Post.fromJson(item));
    }
    notifyListeners();
  }

  Future<void> getPosts() async {
    _listPost.clear();
    String uri = Api.posts;
    var response = await http.get(Uri.parse(uri));
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    var result = results['result'];
    for (var item in result) {
      _listPost.add(Post.fromJson(item));
    }
    notifyListeners();
  }

  Future<String> addPost() async {
    if (_listFile.length > 0) {
      await uploadImage();
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? storeId = await sharedPreferences.getString('store_id');
    String uri = Api.posts;
    // String image = '';
    // for (var item in _images) {
    //   image += item + ',';
    // }
    var response = await http.post(Uri.parse(uri), body: {
      'store_id': storeId,
      'message': _messageController.text,
      'images': _images.join(','),
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    await getPostByStoreId();
    await getPosts();
    resetFile();
    _messageController = TextEditingController();
    notifyListeners();
    return results['msg'];
  }

  Future<String> deletePost({required String postId}) async {
    String uri = Api.deletePost;
    var response = await http.post(Uri.parse(uri), body: {
      'post_id': postId,
    });
    var results = jsonDecode(response.body);
    debugPrint(results.toString());
    notifyListeners();
    await getPostByStoreId();
    await getPosts();
    return results['msg'];
  }

  Future<void> chooseImage(BuildContext ctx, ImageSource imageSource) async {
    var object = await _picker.pickImage(
      source: imageSource,
      maxHeight: 800.0,
      maxWidth: 800.0,
    );

    // _file = io.File(object!.path);
    _listFile.add(io.File(object!.path));
    debugPrint("object length = ${_listFile.length}");
    notifyListeners();
  }

  Future<Null> uploadImage() async {
    _images.clear();
    for (var item in _listFile) {
      Random random = Random();
      int i = random.nextInt(1000000);
      final DateFormat formatter = DateFormat('MMddyyyy');
      String createDate = formatter.format(DateTime.now());
      String nameImage = 'post_image$i' + '_' + '$createDate.jpg';
      // debugPrint(nameImage);

      Map<String, dynamic> map = Map();
      map['file'] =
          await dio.MultipartFile.fromFile(item.path, filename: nameImage);

      dio.FormData formData = dio.FormData.fromMap(map);
      var response = await dio.Dio().post(Api.uploadPostImage, data: formData);
      debugPrint(response.data.toString());
      _images.add(nameImage);
    }
  }

  void printCheckImage() {
    print(_images.toString());
  }

  Future<void> resetFile() async {
    _listFile.clear();
    notifyListeners();
  }

  Future<void> resetIndexFile({required int index}) async {
    _listFile.removeAt(index);
    notifyListeners();
  }
}
