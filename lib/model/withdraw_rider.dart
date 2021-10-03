import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';

import '../utils/api.dart';

class WithdrawRider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  //---------------variable---------------------------

  io.File? _file;

  //---------------GetterSetter-----------------------

  //---------------Method--------------------------------

  Future<void> getWithdraw() async {}

  Future<void> addWithdraw() async {}

  Future<void> updateWithdraw() async {}

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
