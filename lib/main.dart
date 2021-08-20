import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './screens/overview_screen.dart';
import './screens/detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/restaurant_screen.dart';
import './screens/menu_screen.dart';
import './screens/favorite_screen.dart';
import './screens/auth_screen.dart';
import './screens/rider_auth_screen.dart';
import './screens/store_auth_screen.dart';
import './screens/account_screen.dart';
import './screens/rider_screen.dart';
import './screens/store_screen.dart';
import './screens/wallet/rider_wallet_screen.dart';
import './screens/wallet/store_wallet_screen.dart';
import './screens/wallet/rider_credit_screen.dart';
import './screens/wallet/rider_money_screen.dart';
import './screens/income/rider_income_screen.dart';
import './screens/order/rider_order_screen.dart';

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
          // textTheme: GoogleFonts.sarabunTextTheme(
          //   Theme.of(context).textTheme,
          // ),
          primaryColor: Colors.grey.shade100,
          accentColor: Colors.teal,
        ),
        home: OverViewScreen(),
        routes: {
          OverViewScreen.routeName: (ctx) => OverViewScreen(),
          DetailScreen.routeName: (ctx) => DetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          RestaurantScreen.routeName: (ctx) => RestaurantScreen(),
          MenuScreen.routeName: (ctx) => MenuScreen(),
          FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          RiderAuthScreen.routeName: (ctx) => RiderAuthScreen(),
          StoreAuthScreen.routeName: (ctx) => StoreAuthScreen(),
          AccountScreen.routeName: (ctx) => AccountScreen(),
          RiderScreen.routeName: (ctx) => RiderScreen(),
          StoreScreen.routeName: (ctx) => StoreScreen(),
          RiderWalletScreen.routeName: (ctx) => RiderWalletScreen(),
          RiderIncomeScreen.routeName: (ctx) => RiderIncomeScreen(),
          RiderOrderScreen.routeName: (ctx) => RiderOrderScreen(),
          StoreWalletScreen.routeName: (ctx) => StoreWalletScreen(),
          RiderCreditScreen.routeName: (ctx) => RiderCreditScreen(),
          RiderMoneyScreen.routeName: (ctx) => RiderMoneyScreen(),
        },
      ),
    );
  }
}
