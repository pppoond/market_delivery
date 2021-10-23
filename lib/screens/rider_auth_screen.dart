import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './store_auth_screen.dart';
import './rider_screen.dart';

import '../model/rider.dart';

class RiderAuthScreen extends StatefulWidget {
  static const routeName = "/rider-auth-screen";

  @override
  _RiderAuthScreenState createState() => _RiderAuthScreenState();
}

class _RiderAuthScreenState extends State<RiderAuthScreen> {
  bool isLogin = true;
  bool isRider = true;
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
    final rider = Provider.of<Riders>(context, listen: false);
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
                    "เข้าสู่ระบบไรเดอร์",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/delivery.png",
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  userInputField(
                      context: context,
                      labelText: "Username",
                      obscureText: false,
                      controller: rider.usernameController,
                      hintText: "Username",
                      icon: Icon(Icons.person, color: Colors.grey)),
                  userInputField(
                      context: context,
                      labelText: "Password",
                      controller: rider.passwordController,
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
                bool checkLogin = await rider.loginRider(
                    username: rider.usernameController.text,
                    password: rider.passwordController.text);
                if (checkLogin) {
                  print("login success");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RiderScreen.routeName, (route) => false);
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
                    "สมัครบัญชีไรเดอร์",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/delivery.png",
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  userInputField(
                      controller: rider.riderNameController,
                      context: context,
                      labelText: 'ชื่อ',
                      obscureText: false,
                      hintText: "ชื่อ",
                      icon: Icon(Icons.label, color: Colors.grey)),
                  userInputField(
                      onChanged: (value) async {
                        print(value);
                        _usernameNull =
                            await rider.findByUsername(username: value);
                        print("-------------");
                        print(_usernameNull);
                        print("-------------");
                        if (value == "") {
                          _usernameNull = null;
                        }
                        setState(() {});
                      },
                      usernameNull: _usernameNull,
                      controller: rider.usernameController,
                      context: context,
                      labelText: 'Username',
                      obscureText: false,
                      hintText: "Username",
                      icon: Icon(Icons.person, color: Colors.grey)),
                  userInputField(
                      controller: rider.emailController,
                      obscureText: false,
                      hintText: "Email",
                      context: context,
                      labelText: "Email",
                      icon: Icon(Icons.email, color: Colors.grey)),
                  userInputField(
                      controller: rider.riderPhoneController,
                      context: context,
                      labelText: "Phone",
                      obscureText: false,
                      hintText: "Phone",
                      icon: Icon(Icons.phone, color: Colors.grey)),
                  userInputField(
                      controller: rider.passwordController,
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
                      rider.usernameController.text != "" &&
                      rider.passwordController.text != "" &&
                      rider.riderPhoneController.text != "" &&
                      rider.riderNameController.text != "")
                  ? () async {
                      if (rider.usernameController.text != "") {
                        String success = await rider.register();
                        if (success == 'success') {
                          await CoolAlert.show(
                            context: context,
                            title: "สำเร็จ",
                            type: CoolAlertType.success,
                            text: "สมัครสมาชิกสำเร็จ",
                          );
                          rider.riderPhoneController = TextEditingController();
                          rider.emailController = TextEditingController();
                          rider.riderNameController = TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              onPressed: () {
                setState(() {
                  isRider = !isRider;
                });
              },
              child: Text(
                (isRider) ? "ร้านค้า" : "ไรเดอร์",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: (isRider)
          ? ((isLogin) ? loginWidget() : registerWidget())
          : StoreAuthScreen(),
    );
  }
}
