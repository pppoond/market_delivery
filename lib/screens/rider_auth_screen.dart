import 'package:flutter/material.dart';

import './store_auth_screen.dart';
import './rider_screen.dart';

class RiderAuthScreen extends StatefulWidget {
  static const routeName = "/rider-auth-screen";

  @override
  _RiderAuthScreenState createState() => _RiderAuthScreenState();
}

class _RiderAuthScreenState extends State<RiderAuthScreen> {
  bool isLogin = true;
  bool isRider = true;
  Widget userInputField({required String hintText, var icon}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
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
                      hintText: "Email",
                      icon: Icon(Icons.person, color: Colors.grey)),
                  userInputField(
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
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RiderScreen.routeName, (route) => false);
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
                      hintText: "Username",
                      icon: Icon(Icons.person, color: Colors.grey)),
                  userInputField(
                      hintText: "Email",
                      icon: Icon(Icons.email, color: Colors.grey)),
                  userInputField(
                      hintText: "Phone",
                      icon: Icon(Icons.phone, color: Colors.grey)),
                  userInputField(
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
              onPressed: () {},
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
