import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../screens/account/add_address_screen.dart';

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
  TextEditingController sexTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();

  Customer? customerModel;

  // dynamic customerProvider;

  double? lat;
  double? lng;

  int? dropdownValue = 1;
  int? _selectedValue = 1;
  String? customerName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      findLatLng();
      // await this.updateUI();
      await getCustomer(ctx: context);
      // customerProvider = Provider.of<Customers>(context, listen: false);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customers>(context, listen: false);

    // dropdownValue = 1;
    // _selectedValue = 0;
    // getCustomer(ctx: context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("บัญชีผู้ใช้"),
        actions: [
          TextButton(
              style: ButtonStyle(),
              onPressed: () async {
                await checkTextFieldNotNull().then((value) {
                  print(value);
                  if (value == true) {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        title: "ต้องการบันทึกข้อมูลหรือไม่ ?",
                        confirmBtnText: "ยืนยัน",
                        onConfirmBtnTap: () {
                          if (file != null) {
                            uploadImage(context: context);
                          } else {
                            int sex = (_selectedValue! + 1);
                            customer
                                .updateCustomer(
                              customerId: customerModel!.customerId,
                              username: usernameTextController.text,
                              password: passwordTextController.text,
                              customerName: customerNameTextController.text,
                              customerPhone: customerPhoneTextController.text,
                              sex: sex,
                              profileImage: customerModel!.profileImage,
                            )
                                .then((value) {
                              print("${value.data['msg']}");
                              var results = value.data;
                              if (results['msg'] == "success") {
                                print("Success");
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                ).then((value) {
                                  customer.findCustomer();
                                  getCustomer(ctx: context).then(
                                      (value) => Navigator.of(context).pop());
                                });
                              } else {
                                print("Error");
                                CoolAlert.show(
                                  context: context,
                                  title: "มีข้อผิดพลาด",
                                  text: "กรุณาลองใหม่อีกครั้ง",
                                  type: CoolAlertType.error,
                                );
                              }
                              print("Finish");
                            });
                          }
                        },
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
              child: Text(
                "บันทึก",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
        toolbarHeight: 45,
        elevation: 1,
      ),
      body: ListView(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<Customers>(
                  builder: (context, customerData, child) => Center(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      radius: 50,
                      backgroundImage: (file != null)
                          ? FileImage(file!)
                          : (customerModel?.profileImage != null)
                              ? (customerModel?.profileImage != "")
                                  ? NetworkImage(Api.imageUrl +
                                      customerModel!.profileImage)
                                  : AssetImage("assets/images/user.png")
                                      as ImageProvider
                              : AssetImage("assets/images/user.png"),
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
                    hintText: "ชื่อ",
                    controller: (context)
                        .watch<Customers>()
                        .customerNameTextController),
                TextFieldWidget(
                    icon: Icon(Icons.phone_iphone),
                    hintText: "มือมือ",
                    controller: customerPhoneTextController),
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
                            controller: sexTextController),
                      ),
                      // GestureDetector(
                      //   child: _selectedValue == 0
                      //       ? Text("ชาย")
                      //       : _selectedValue == 1
                      //           ? Text("หญิง")
                      //           : Text("อื่นๆ"),
                      // ),
                    ],
                  ),
                ),
                // GestureDetector(
                //   child: Container(
                //     margin: EdgeInsets.only(bottom: 12),
                //     child: Text(
                //       "แก้ไขรหัสผ่าน",
                //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.zero,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushNamed(AccountScreen.routeName);
                    },
                    child: Text(
                      "แก้ไขรหัสผ่าน",
                      style: TextStyle(
                          // color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextFieldWidget(
                  obscureText: true,
                  hintText: "รหัสผ่าน",
                  controller: passwordTextController,
                ),
                // showImage(),
                // Container(
                //   child: Padding(
                //     padding: EdgeInsets.all(0.0),
                //     child: TextButton(
                //       onPressed: () async {
                //         await checkTextFieldNotNull().then((value) {
                //           print(value);
                //           if (value == true) {
                //             CoolAlert.show(
                //                 context: context,
                //                 type: CoolAlertType.confirm,
                //                 title: "ต้องการบันทึกข้อมูลหรือไม่ ?",
                //                 confirmBtnText: "ยืนยัน",
                //                 onConfirmBtnTap: () {
                //                   if (file != null) {
                //                     uploadImage(context: context);
                //                   } else {
                //                     int sex = (_selectedValue! + 1);
                //                     customer
                //                         .updateCustomer(
                //                       customerId: customerModel!.customerId,
                //                       username: usernameTextController.text,
                //                       password: passwordTextController.text,
                //                       customerName:
                //                           customerNameTextController.text,
                //                       customerPhone:
                //                           customerPhoneTextController.text,
                //                       sex: sex,
                //                       profileImage: customerModel!.profileImage,
                //                     )
                //                         .then((value) {
                //                       print("${value.data['msg']}");
                //                       var results = value.data;
                //                       if (results['msg'] == "success") {
                //                         print("Success");
                //                         CoolAlert.show(
                //                           context: context,
                //                           type: CoolAlertType.success,
                //                         ).then((value) {
                //                           customer.findCustomer();
                //                           getCustomer(ctx: context).then(
                //                               (value) =>
                //                                   Navigator.of(context).pop());
                //                         });
                //                       } else {
                //                         print("Error");
                //                         CoolAlert.show(
                //                           context: context,
                //                           title: "มีข้อผิดพลาด",
                //                           text: "กรุณาลองใหม่อีกครั้ง",
                //                           type: CoolAlertType.error,
                //                         );
                //                       }
                //                       print("Finish");
                //                     });
                //                   }
                //                 },
                //                 cancelBtnText: "ยกเลิก");
                //           } else {
                //             CoolAlert.show(
                //               context: context,
                //               type: CoolAlertType.error,
                //               title: "กรุณากรอกรหัสผ่าน",
                //             );
                //           }
                //         });
                //       },
                //       style: TextButton.styleFrom(
                //         primary: Colors.white,
                //         backgroundColor: Theme.of(context).accentColor,
                //         minimumSize: Size(
                //           double.infinity,
                //           50,
                //         ),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //       child: Text(
                //         "บันทึก",
                //         style: TextStyle(
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ที่อยู่",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).accentColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                              "บ้านเลขที่ 16 ซอย 4 หมู่บ้านเดอะชิล ต.ในเมือง อ.เมือง จ.มหาสารคาม",
                              style: TextStyle(color: Colors.white),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.zero,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushNamed(AccountScreen.routeName);
                      // showModal(ctx: context);
                      // Navigator.of(context)
                      //     .pushNamed(AddAddressScreen.routeName);
                      showModal(ctx: context);
                    },
                    child: Text(
                      "แก้ไขที่อยู่",
                      style: TextStyle(
                          // color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
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

  Future<Null> uploadImage({required BuildContext context}) async {
    final customerProvider = Provider.of<Customers>(context, listen: false);
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'customer$i.jpg';
    int sex = (_selectedValue! + 1);
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
        // updateCustomer(ctx: context, profile_image: nameImage);
        customerProvider
            .updateCustomer(
          customerId: customerModel!.customerId,
          username: usernameTextController.text,
          password: passwordTextController.text,
          customerName: customerNameTextController.text,
          customerPhone: customerPhoneTextController.text,
          sex: sex,
          profileImage: nameImage,
        )
            .then((value) {
          print("${value.data['msg']}");
          var results = value.data;
          if (results['msg'] == "success") {
            print("Success");
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
            ).then((value) async {
              await getCustomer(ctx: context)
                  .then((value) => Navigator.of(context).pop());
            });
          } else {
            print("Error");
            CoolAlert.show(
              context: context,
              title: "มีข้อผิดพลาด",
              text: "กรุณาลองใหม่อีกครั้ง",
              type: CoolAlertType.error,
            );
          }
          print("Finish");
        });
      });
    } catch (e) {}
  }

  // Future<Null> updateCustomer(
  //     {required BuildContext ctx, String? profile_image}) async {
  //   print("update Customer");
  //   int sex = (_selectedValue! + 1);
  //   var formData = dio.FormData.fromMap({
  //     "customer_id": customerModel?.customerId,
  //     "username": usernameTextController.text,
  //     "password": passwordTextController.text,
  //     "customer_name": customerNameTextController.text,
  //     "customer_phone": customerPhoneTextController.text,
  //     "sex": sex,
  //     "profile_image": profile_image,
  //   });
  //   try {
  //     await dio.Dio().post(Api.updateCustomer, data: formData).then((value) {
  //       print("${value.data['msg']}");
  //       var results = value.data;
  //       if (results['msg'] == "success") {
  //         print("Success");
  //         CoolAlert.show(
  //           context: context,
  //           type: CoolAlertType.success,
  //         ).then((value) {
  //           getCustomer(ctx: ctx);
  //           Navigator.of(context).pop();
  //         });
  //       } else {
  //         print("Error");
  //         CoolAlert.show(
  //           context: context,
  //           title: "มีข้อผิดพลาด",
  //           text: "กรุณาลองใหม่อีกครั้ง",
  //           type: CoolAlertType.error,
  //         );
  //       }
  //       print("Finish");
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
    customerModel = await customer.customerModel;
    if (customerModel!.sex == "1") {
      _selectedValue = 0;
      customerName = "ชาย";
    } else if (customerModel!.sex == "2") {
      _selectedValue = 1;
      customerName = "หญิง";
    } else {
      _selectedValue = 2;
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
    print("username : ${usernameTextController.text}");
    print("password : ${passwordTextController.text}");
    print("customerName : ${customerNameTextController.text}");
    print("customerPhone : ${customerPhoneTextController.text}");
    print("sex : ${sexTextController.text}");
    if (usernameTextController.text != "" &&
        passwordTextController.text != "" &&
        customerNameTextController.text != "" &&
        customerPhoneTextController.text != "" &&
        sexTextController.text != "") {
      print("Not Null");
      notNull = true;
    } else {
      print("Null");
      notNull = false;
    }
    return notNull;
  }

  showModal({required BuildContext ctx}) {
    // final customer = Provider.of<Customers>(ctx, listen: false);
    int isSelect = 0;
    return showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (ctx) {
          return Consumer<Customers>(
            builder: (ctx, customerData, child) =>
                StatefulBuilder(builder: (ctx, setState) {
              return Container(
                height: MediaQuery.of(ctx).size.height * 0.85,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "แก้ไขที่อยู่",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            isSelect = 0;
                                            customerData.notifyListeners();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 7),
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: (isSelect == 0)
                                                  ? Theme.of(context)
                                                      .accentColor
                                                  : Colors.grey.shade400,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  "บ้านเลขที่ 16 ซอย 4 หมู่บ้านเดอะชิล ต.ในเมือง อ.เมือง จ.มหาสารคาม",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            isSelect = 1;
                                            customerData.notifyListeners();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 7),
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: (isSelect == 1)
                                                  ? Theme.of(context)
                                                      .accentColor
                                                  : Colors.grey.shade400,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  "หอเดอะชิล 16 มมส ต.ท่าขอนยาง อ.กันทรวิชัย จ.มหาสารคาม",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Divider(),
                                        TextFieldWidget(
                                          hintText: "ที่อยู่",
                                          controller: addressTextController,
                                          // icon: TextButton(
                                          //   onPressed: () {
                                          //     customerData.showConfirmAlert(
                                          //         context: context);
                                          //   },
                                          //   child: Text("เพิ่มที่อยู่"),
                                          // ),
                                          suffixIconEndable: true,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_pin),
                                            Container(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            AddAddressScreen
                                                                .routeName);
                                                  },
                                                  child: Text(
                                                    "ปักหมุดที่ตั้ง",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: customerData.lat != null
                                                    ? Text(
                                                        "Latitude : ${customerData.lat}\nLongtitude : ${customerData.lng}")
                                                    : Text(""),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: showMap(ctx: ctx)),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0)),
                                      onPressed: () {
                                        CoolAlert.show(
                                            context: context,
                                            title:
                                                "ต้องการบันทึกที่อยู่หรือไม่",
                                            confirmBtnText: "บันทึก",
                                            cancelBtnText: "ยกเลิก",
                                            type: CoolAlertType.confirm,
                                            onConfirmBtnTap: () {
                                              customerData
                                                  .addAddress()
                                                  .then((value) {
                                                var results = jsonDecode(value);
                                                if (results['msg'] ==
                                                    "success") {
                                                  CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType
                                                          .success);
                                                } else {
                                                  CoolAlert.show(
                                                      context: context,
                                                      type:
                                                          CoolAlertType.error);
                                                }
                                              });
                                            });
                                      },
                                      child: Text("เพิ่มที่อยู่"))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  Container showMap({required BuildContext ctx, LatLng? latLng}) {
    // LatLng latLng = LatLng(16.20144295022659, 103.28276975227374);
    // LatLng? onTapMap;

    List<Marker> _marker = [];
    return Container(
      child: Consumer<Customers>(
        builder: (ctx, customerData, child) => Container(
          child: GoogleMap(
            onTap: (LatLng latLng) {
              // onTapMap = LatLng(latLng.latitude, latLng.longitude);
              print("on tap map");
              print("Lat : ${latLng.latitude} Lng : ${latLng.longitude}");
              _marker = [];
              _marker.add((Marker(
                markerId: MarkerId(latLng.toString()),
                position: latLng,
              )));
              customerData.notifyListeners();
            },

            initialCameraPosition: CameraPosition(
              target: LatLng(
                  customerData.lat != null ? customerData.lat! : 16.0132,
                  customerData.lng != null ? customerData.lng! : 103.1615),
              zoom: 16.0,
            ),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            // myLocationEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(customerData.lat!, customerData.lng!),
                      zoom: 15),
                ),
              );
            },
            // markers: Set.from(_marker),
            markers: {
              if (customerData.lat != null)
                Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(customerData.lat!, customerData.lng!),
                  // infoWindow: InfoWindow(
                  //     title: "สนามบินสุวรรณภูมิ",
                  //     snippet: "สนามบินนานาชาติของประเทศไทย"),
                ),
            },
          ),
        ),
      ),
    );
  }

  Future<Null> findLatLng() async {
    LocationData? locationData = await findLocationData();
    lat = locationData!.latitude;
    lng = locationData.longitude;
    print('lat : $lat  lng : $lng');
  }

  Future<LocationData?> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }
}
