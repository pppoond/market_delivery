import 'package:flutter/material.dart';
import './screens/overview_screen.dart';
import './screens/detail_screen.dart';

import 'package:provider/provider.dart';

import './model/restaurants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Restaurants(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.grey.shade100,
          accentColor: Colors.teal,
        ),
        home: OverViewScreen(),
        routes: {
          DetailScreen.routeName: (ctx) => DetailScreen(),
        },
      ),
    );
  }
}
