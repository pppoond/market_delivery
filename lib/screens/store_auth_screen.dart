import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/auth/auth_logo.dart';
import './store_screen.dart';

import '../model/store.dart';

class StoreAuthScreen extends StatefulWidget {
  static const routeName = "/store-auth-screen";

  @override
  _StoreAuthScreenState createState() => _StoreAuthScreenState();
}

class _StoreAuthScreenState extends State<StoreAuthScreen> {
  bool isLogin = true;
  bool isstore = true;
  bool? _usernameNull;
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  Widget userInputField(
      {required BuildContext context,
      required String hintText,
      required String labelText,
      var icon,
      var usernameNull,
      Function(String)? onChanged,
      TextEditingController? controller,
      required bool obscureText}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          suffix: (usernameNull != null)
              ? (usernameNull)
                  ? Text(
                      "ใช้งานได้",
                      style: TextStyle(color: Colors.green.shade500),
                    )
                  : Text(
                      "มีผู้ใช้งานแล้ว",
                      style: TextStyle(color: Colors.red.shade500),
                    )
              : null,
          prefixIcon: (icon == null) ? null : icon,
          // icon: (icon == null) ? null : icon,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).accentColor)),
        ),
        // focusedBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //         width: 1, color: Theme.of(context).accentColor))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Stores>(context, listen: false);
    Scaffold loginWidget() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "เข้าสู่ระบบร้านค้า",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/shops.png",
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  userInputField(
                      context: context,
                      labelText: "Username",
                      controller: store.usernameTextController,
                      obscureText: false,
                      hintText: "Username",
                      icon: Icon(Icons.person, color: Colors.grey)),
                  userInputField(
                      context: context,
                      labelText: "Password",
                      controller: store.passwordTextController,
                      obscureText: true,
                      hintText: "Password",
                      icon: Icon(Icons.lock, color: Colors.grey)),
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text("ยังไม่มีบัญชีใช่หรือไม่?"),
                        TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              "สมัครสมาชิก",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: () async {
                bool? checkLogin = await store.loginStore(
                    username: store.usernameTextController.text,
                    password: store.passwordTextController.text);
                if (checkLogin) {
                  print("login success");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      StoreScreen.routeName, (route) => false);
                } else {
                  print("login unsuccess");
                }
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
                "เข้าสู่ระบบ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Scaffold registerWidget() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "สมัครบัญชีร้านค้า",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/shops.png",
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  userInputField(
                      controller: store.storeNameTextController,
                      context: context,
                      labelText: "ชื่อร้าน",
                      obscureText: false,
                      hintText: "ชื่อร้าน",
                      icon: Icon(Icons.label, color: Colors.grey)),
                  userInputField(
                      onChanged: (value) async {
                        print(value);
                        _usernameNull =
                            await store.findUsername(username: value);
                        print("-------------");
                        print(_usernameNull);
                        print("-------------");
                        if (value == "") {
                          _usernameNull = null;
                        }
                        setState(() {});
                      },
                      usernameNull: _usernameNull,
                      controller: store.usernameTextController,
                      context: context,
                      labelText: 'Username',
                      obscureText: false,
                      hintText: "Username",
                      icon: Icon(Icons.person, color: Colors.grey)),
                  userInputField(
                      controller: store.emailTextController,
                      context: context,
                      labelText: "Email",
                      obscureText: false,
                      hintText: "Email",
                      icon: Icon(Icons.email, color: Colors.grey)),
                  userInputField(
                      controller: store.storePhoneTextController,
                      context: context,
                      labelText: "Phone",
                      obscureText: false,
                      hintText: "Phone",
                      icon: Icon(Icons.phone, color: Colors.grey)),
                  userInputField(
                      controller: store.passwordTextController,
                      context: context,
                      labelText: "Password",
                      obscureText: true,
                      hintText: "Password",
                      icon: Icon(Icons.lock, color: Colors.grey)),
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text("มีบัญชีแล้ว?"),
                        TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              "เข้าสู่ระบบ",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: (_usernameNull != null &&
                      _usernameNull != false &&
                      store.usernameTextController.text != "" &&
                      store.passwordTextController.text != "" &&
                      store.storePhoneTextController.text != "" &&
                      store.storeNameTextController.text != "")
                  ? () async {
                      if (store.usernameTextController.text != "") {
                        String success = await store.register();
                        if (success == 'success') {
                          await CoolAlert.show(
                            context: context,
                            title: "สำเร็จ",
                            type: CoolAlertType.success,
                            text: "สมัครสมาชิกสำเร็จ",
                          );
                          store.storePhoneTextController =
                              TextEditingController();
                          store.emailTextController = TextEditingController();
                          store.storeNameTextController =
                              TextEditingController();

                          setState(() {
                            isLogin = !isLogin;
                          });
                        } else {
                          CoolAlert.show(
                            context: context,
                            title: "ผิดพลาด",
                            type: CoolAlertType.error,
                            text: "ข้อมูลไม่ถูกต้อง",
                          );
                        }
                      } else {
                        CoolAlert.show(
                          context: context,
                          title: "คำเตือน",
                          type: CoolAlertType.warning,
                          text: "กรุณากรอกข้อมูลให้ครบ",
                        );
                      }
                    }
                  : null,
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
                "สมัครสมาชิก",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: (isLogin) ? loginWidget() : registerWidget(),
    );
  }
}
