import 'dart:io' as io;
import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart' as dio;

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
  TextEditingController usernameTextController = TextEditingController();

  TextEditingController passwordTextController = TextEditingController();

  TextEditingController customerNameTextController = TextEditingController();

  TextEditingController customerPhoneTextController = TextEditingController();

  Customer? customerModel;

  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customers>(context, listen: false);
    customer.findCustomer();
    customerModel = customer.customerModel;
    usernameTextController.text = customerModel!.username;

    // passwordTextController.text = customerModel!.password;
    customerNameTextController.text = customerModel!.customerName;

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
              CircleAvatar(
                radius: 50,
              ),
              SizedBox(
                height: 7,
              ),
              TextFieldWidget(
                hintText: "ชื่อผู้ใช้",
                controller: usernameTextController,
                readOnly: true,
                enabled: false,
              ),
              TextFieldWidget(
                  hintText: "ชื่อ", controller: customerNameTextController),
              TextFieldWidget(
                  hintText: "Username", controller: usernameTextController),
              Consumer<Customers>(
                builder: (context, customerData, child) => DropdownButton<int>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Theme.of(context).accentColor),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) {
                    dropdownValue = newValue!;
                    customerData.notifyListeners();
                  },
                  items: <int>[
                    1,
                    2,
                  ].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      // child: Text(value),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.all(7),
                        // color: Colors.red,
                        child: Row(
                          children: [
                            Text(
                              value == 1
                                  ? "ชาย"
                                  : value == 2
                                      ? "หญิง"
                                      : "อื่นๆ",
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              TextFieldWidget(
                obscureText: true,
                hintText: "รหัสผ่าน",
                controller: passwordTextController,
              ),
              showImage(),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextButton(
                    onPressed: () async {
                      // bool checkLogin = await rider.loginRider(
                      //     username: usernameTextController.text,
                      //     password: passwordTextController.text);
                      // // print("5555555555555555555");
                      // // print(checkLogin.toString());
                      // if (checkLogin) {
                      //   print("login success");
                      //   Navigator.of(context).pushNamedAndRemoveUntil(
                      //       RiderScreen.routeName, (route) => false);
                      // } else {
                      //   print("login unsuccess");
                      // }
                      uploadImage();
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

  Container showImage() {
    return Container(
      child: Row(
        children: [
          InkWell(
            onTap: () => chooseImage(ImageSource.camera),
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
            onTap: () => chooseImage(ImageSource.gallery),
            child: Icon(Icons.photo),
          )
        ],
      ),
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await _picker.pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );
      setState(() {
        file = io.File(object!.path);
      });
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
        print("$nameImage");
        // dio.Dio().put(Api.customer, data: {
        //   "username": usernameTextController.text,
        //   "password": passwordTextController.text,
        //   "customer_name": customerNameTextController.text,
        //   "customer_phone": customerPhoneTextController.text,
        //   "sex": dropdownValue,
        //   "profile_image": nameImage,
        // }).then((value) {});
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
        );
      });
    } catch (e) {}
  }
}
