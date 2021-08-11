import 'package:flutter/material.dart';

import '../widgets/auth/auth_logo.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth-screen";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  Widget userInputField({required String hintText, var icon}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            // prefixIcon: Icon(Icons.email),
            icon: (icon == null) ? null : icon,
            hintText: hintText,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (isLogin)
                    ? AuthLogo()
                    : Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                SizedBox(
                  height: 50,
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
                      Text((isLogin)
                          ? "Dont have an account ?"
                          : "Already have account?"),
                      TextButton(
                          style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.zero),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            (isLogin) ? "Sign Up" : "Login",
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
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
              (isLogin) ? "Login" : "Sign Up",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
