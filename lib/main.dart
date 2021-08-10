import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/overview_screen.dart';
import './screens/detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/restaurant_screen.dart';
import './screens/menu_screen.dart';
import './screens/favorite_screen.dart';
import './screens/auth_screen.dart';

import './model/restaurants.dart';
import './model/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Restaurants(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.grey.shade100,
          accentColor: Colors.teal,
        ),
        home: OverViewScreen(),
        routes: {
          DetailScreen.routeName: (ctx) => DetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          RestaurantScreen.routeName: (ctx) => RestaurantScreen(),
          MenuScreen.routeName: (ctx) => MenuScreen(),
          FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}
