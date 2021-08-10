import 'package:flutter/material.dart';

import '../widgets/auth/auth_logo.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth-screen";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
              children: [
                AuthLogo(),
                userInputField(
                    hintText: "Email",
                    icon: Icon(Icons.person, color: Colors.grey)),
                userInputField(
                    hintText: "Password",
                    icon: Icon(Icons.lock, color: Colors.grey)),
                SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    Text("Dont have an account ?"),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ))
                  ],
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
              "Login",
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
