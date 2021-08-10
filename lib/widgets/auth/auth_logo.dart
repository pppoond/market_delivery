import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned(
            child: FlutterLogo(
              size: 280,
              style: FlutterLogoStyle.horizontal,
            ),
          ),
          Positioned(
            bottom: 90,
            child: Text(
              "Build Delivery App",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
