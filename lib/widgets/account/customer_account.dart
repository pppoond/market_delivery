import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import '../../model/customer.dart';

import '../../utils/api.dart';

import '../../widgets/text_field_widget.dart';

class CustomerAccount extends StatefulWidget {
  @override
  State<CustomerAccount> createState() => _CustomerAccountState();
}

class _CustomerAccountState extends State<CustomerAccount> {
  io.File? file;
  final ImagePicker _picker = ImagePicker();
  TextEditingController? usernameTextController;

  TextEditingController? passwordTextController;

  TextEditingController? customerNameTextController;

  TextEditingController? customerPhoneTextController;

  TextEditingController? sexTextController = TextEditingController();

  Customer? customerModel;

  int? dropdownValue = 1;
  int? _selectedValue = 1;
  String? customerName;

  @override
  Widget build(BuildContext context) {
    // final customer = Provider.of<Customers>(context, listen: false);

    // dropdownValue = 1;
    // _selectedValue = 0;
    getCustomer(ctx: context);
    return ListView(
      padding: EdgeInsets.only(left: 16, right: 16),
      children: [
        SizedBox(
          height: 7,
        ),
        Text(
          "แก้ไขบัญชีผู้ใช้งาน",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Divider(),
        SizedBox(
          height: 7,
        ),
        Container(
          child: Column(
            children: [
              Consumer<Customers>(
                builder: (context, customerData, child) => CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  radius: 50,
                  backgroundImage: (file != null)
                      ? FileImage(file!)
                      : (customerModel!.profileImage.isNotEmpty)
                          ? NetworkImage(
                              Api.imageUrl + customerModel!.profileImage)
                          : AssetImage("assets/images/user.png")
                              as ImageProvider,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // color: Colors.black.withOpacity(0.5),
                          gradient: LinearGradient(
                              colors: [
                                Colors.black87.withOpacity(.5),
                                Colors.transparent
                              ],
                              begin: const FractionalOffset(0.0, 0.5),
                              end: const FractionalOffset(0.0, 0.0),
                              stops: [0.0, 0.0],
                              tileMode: TileMode.clamp),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            print("Select Image");
                            showAlertImage(
                              title: "",
                              content: "",
                              context: context,
                              defaultActionText: "Camera",
                              cancelActionText: "Gallary",
                            );
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white38,
                            size: 27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextFieldWidget(
                hintText: "ชื่อผู้ใช้",
                controller: usernameTextController!,
                readOnly: true,
                enabled: false,
              ),
              TextFieldWidget(
                  hintText: "ชื่อ", controller: customerNameTextController!),
              TextFieldWidget(
                  hintText: "มือมือ", controller: customerPhoneTextController!),
              Consumer<Customers>(
                builder: (context, customerData, child) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showSexPicker(context);
                      },
                      child: TextFieldWidget(
                          suffixIconEndable: true,
                          icon: Icon(Icons.arrow_downward),
                          // enabled: false,
                          enabled: false,
                          readOnly: true,
                          hintText: "ชื่อ",
                          controller: sexTextController!),
                    ),
                    GestureDetector(
                      child: _selectedValue == 0
                          ? Text("ชาย")
                          : _selectedValue == 1
                              ? Text("หญิง")
                              : Text("อื่นๆ"),
                    ),
                  ],
                ),
              ),
              TextFieldWidget(
                obscureText: true,
                hintText: "รหัสผ่าน",
                controller: passwordTextController!,
              ),
              // showImage(),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextButton(
                    onPressed: () async {
                      await checkTextFieldNotNull().then((value) {
                        print(value);
                        if (value == true) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              title: "ต้องการบันทึกข้อมูลหรือไม่ ?",
                              confirmBtnText: "ยืนยัน",
                              onConfirmBtnTap: () => uploadImage(),
                              cancelBtnText: "ยกเลิก");
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: "กรุณากรอกรหัสผ่าน",
                          );
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).accentColor,
                      minimumSize: Size(
                        double.infinity,
                        50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "บันทึก",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  showImage(BuildContext ctx) {
    return Consumer<Customers>(
      builder: (ctx, customerData, child) => Container(
        child: Row(
          children: [
            InkWell(
              onTap: () => chooseImage(ctx, ImageSource.camera),
              child: Icon(Icons.camera),
            ),
            Container(
              child: file == null
                  ? Container()
                  : Image.file(
                      file!,
                      width: MediaQuery.of(context).size.width * .5,
                    ),
            ),
            InkWell(
              onTap: () => chooseImage(ctx, ImageSource.gallery),
              child: Icon(Icons.photo),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> chooseImage(BuildContext ctx, ImageSource imageSource) async {
    final customer = Provider.of<Customers>(ctx, listen: false);
    try {
      var object = await _picker.pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      file = io.File(object!.path);
      customer.notifyListeners();
    } catch (e) {}
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'customer$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await dio.MultipartFile.fromFile(file!.path, filename: nameImage);

      dio.FormData formData = dio.FormData.fromMap(map);
      await dio.Dio().post(Api.uploadImage, data: formData).then((value) {
        print("Response ==>> $value");
        print("name image");
        print("$nameImage");
        print("name image");
        updateCustomer(profile_image: nameImage);
      });
    } catch (e) {}
  }

  Future<Null> updateCustomer({String? profile_image}) async {
    print("update Customer");
    var formData = dio.FormData.fromMap({
      "customer_id": customerModel!.customerId,
      "username": usernameTextController!.text,
      "password": passwordTextController!.text,
      "customer_name": customerNameTextController!.text,
      "customer_phone": customerPhoneTextController!.text,
      "sex": dropdownValue,
      "profile_image": profile_image,
    });
    try {
      await dio.Dio().post(Api.updateCustomer, data: formData).then((value) {
        print("${value.data['msg']}");
        var results = value.data;
        if (results['msg'] == "success") {
          print("Success");
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
          );
        } else {
          print("Error");
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
          );
        }
        print("Finish");
      });
    } catch (e) {
      print(e);
    }
  }

  void _showSexPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: MediaQuery.of(ctx).size.height * 1,
              height: MediaQuery.of(ctx).size.height * 0.3,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                scrollController:
                    FixedExtentScrollController(initialItem: _selectedValue!),
                children: [
                  Text('ชาย'),
                  Text('หญิง'),
                  Text('อื่นๆ'),
                ],
                onSelectedItemChanged: (value) {
                  final customer = Provider.of<Customers>(ctx, listen: false);
                  print(value);
                  sexTextController =
                      TextEditingController(text: returnSex(value));
                  _selectedValue = value;
                  customer.notifyListeners();
                },
              ),
            ));
  }

  Future<dynamic> showAlertImage({
    required BuildContext context,
    required String title,
    required String content,
    String? cancelActionText,
    required String defaultActionText,
  }) async {
    // todo : showDialog for ios
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        // title: Text(title),
        // content: Text(content),
        actions: [
          CupertinoDialogAction(
              onPressed: () => chooseImage(context, ImageSource.camera)
                  .then((value) => Navigator.of(context).pop()),
              child: Text("กล้อง")),
          CupertinoDialogAction(
              onPressed: () => chooseImage(context, ImageSource.gallery)
                  .then((value) => Navigator.of(context).pop()),
              child: Text("รูปภาพ")),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("ยกเลิก"),
            textStyle: TextStyle(color: Colors.redAccent),
          ),
        ],
      ),
    );
  }

  Future<Null> getCustomer({required BuildContext ctx}) async {
    print("Get Customer");
    final customer = Provider.of<Customers>(ctx, listen: false);
    customer.findCustomer();
    customerModel = customer.customerModel;

    if (customerModel!.sex == "1") {
      customerName = "ชาย";
    } else if (customerModel!.sex == "2") {
      customerName = "หญิง";
    } else {
      customerName = "อื่นๆ";
    }
    usernameTextController =
        TextEditingController(text: customerModel!.username);
    customerPhoneTextController =
        TextEditingController(text: customerModel!.customerPhone);
    passwordTextController = TextEditingController(text: "");
    customerNameTextController =
        TextEditingController(text: customerModel!.customerName);
    sexTextController = TextEditingController(text: customerName);
  }

  returnSex(var val) {
    String? customerName;
    if (val == 0) {
      customerName = "ชาย";
    } else if (val == 1) {
      customerName = "หญิง";
    } else {
      customerName = "อื่นๆ";
    }
    return customerName;
  }

  Future<bool> checkTextFieldNotNull() async {
    bool? notNull;
    print("username : ${usernameTextController!.text}");
    print("password : ${passwordTextController!.text}");
    print("customerName : ${customerNameTextController!.text}");
    print("customerPhone : ${customerPhoneTextController!.text}");
    print("sex : ${sexTextController!.text}");
    if (usernameTextController!.text != "" &&
        passwordTextController!.text != "" &&
        customerNameTextController!.text != "" &&
        customerPhoneTextController!.text != "" &&
        sexTextController!.text != "") {
      print("Not Null");
      notNull = true;
    } else {
      print("Null");
      notNull = false;
    }
    return notNull;
  }
}
