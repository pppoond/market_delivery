import 'package:flutter/material.dart';
import './screens/overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey.shade100,
        accentColor: Colors.teal,
      ),
      home: OverViewScreen(),
    );
  }
}
