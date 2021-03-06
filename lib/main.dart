import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:market_delivery/screens/store/store_detail_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
import './screens/order/rider_finish_screen.dart';
import './screens/order/rider_result_screen.dart';
import './screens/account/add_address_screen.dart';
import './screens/store/product_management_screen.dart';
import './screens/store/add_product.screen.dart';
import './screens/rider/rider_work_screen.dart';
import './screens/rider/edit_rider_profile_screen.dart';
import './screens/store/edit_store_profile_screen.dart';
import './screens/wallet/store_money_screen.dart';
import './screens/store/store_setting_screen.dart';
import './screens/store/store_password_screen.dart';
import './screens/store/store_location_screen.dart';
import './screens/wallet/store_withdraw_history_screen.dart';
import './screens/wallet/rider_withdraw_history_screen.dart';
import './screens/customer/customer_order_screen.dart';
import './screens/customer/order_detail_screen.dart';
import './screens/rider/rider_inorder_screen.dart';
import './screens/rider/rider_order_detail_screen.dart';
import './screens/rider/rider_confirm_order_status_screen.dart';
import './screens/rider/rider_delivery_point_screen.dart';
import './screens/rider/rider_confirm_customer_order_screen.dart';
import './screens/wallet/rider_payment_history_screen.dart';
import './screens/store/store_order_screen.dart';
import './screens/store/store_order_today_screen.dart';
import './screens/store/store_order_today_success_screen.dart';
import './screens/store/store_order_today_cancel_screen.dart';
import './screens/store/store_report_screen.dart';
import './screens/store/edit_post_screen.dart';

import './model/restaurants.dart';
import './model/cart.dart';
import './model/rider.dart';
import './model/customer.dart';
import './model/store.dart';
import './model/product_image.dart';
import './model/product.dart';
import './model/order.dart';
import './model/withdraw_store.dart';
import './model/order_detail.dart';
import './model/withdraw_rider.dart';
import './model/admin.dart';
import './model/payment_rider.dart';
import './model/category.dart';
import './model/post.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic screen = await checkLogin();
  runApp(MyApp(
    screen: screen,
  ));
}

Future<dynamic> checkLogin() async {
  dynamic screen;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var type = sharedPreferences.getString("type");
  if (type != null) {
    if (type == "customer") {
      screen = OverViewScreen();
    } else if (type == "rider") {
      screen = RiderScreen();
    } else if (type == "store") {
      screen = StoreScreen();
    } else {
      screen = OverViewScreen();
    }
  } else {
    screen = OverViewScreen();
  }
  return screen;
}

class MyApp extends StatelessWidget {
  dynamic screen;
  MyApp({this.screen});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Restaurants(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Riders(),
        ),
        ChangeNotifierProvider(
          create: (context) => Customers(),
        ),
        ChangeNotifierProvider(
          create: (context) => Stores(),
        ),
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductImages(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (context) => WithdrawStores(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderDetails(),
        ),
        ChangeNotifierProvider(
          create: (context) => WithdrawRiders(),
        ),
        ChangeNotifierProvider(
          create: (context) => Admins(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentRiders(),
        ),
        ChangeNotifierProvider(
          create: (context) => Categorys(),
        ),
        ChangeNotifierProvider(
          create: (context) => Posts(),
        ),
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
        home: screen,
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
          RiderFinishScreen.routeName: (ctx) => RiderFinishScreen(),
          StoreWalletScreen.routeName: (ctx) => StoreWalletScreen(),
          RiderCreditScreen.routeName: (ctx) => RiderCreditScreen(),
          RiderMoneyScreen.routeName: (ctx) => RiderMoneyScreen(),
          RiderResultScreen.routeName: (ctx) => RiderResultScreen(),
          AddAddressScreen.routeName: (ctx) => AddAddressScreen(),
          ProductManagementScreen.routeName: (ctx) => ProductManagementScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          StoreDetailScreen.routeName: (ctx) => StoreDetailScreen(),
          RiderWorkScreen.routeName: (ctx) => RiderWorkScreen(),
          EditRiderProfileScreen.routeName: (ctx) => EditRiderProfileScreen(),
          EditStoreProfileScreen.routeName: (ctx) => EditStoreProfileScreen(),
          StoreMoneyScreen.routeName: (ctx) => StoreMoneyScreen(),
          StoreSettingScreen.routeName: (ctx) => StoreSettingScreen(),
          StorePasswordScreen.routeName: (ctx) => StorePasswordScreen(),
          StoreLocationScreen.routeName: (ctx) => StoreLocationScreen(),
          StoreWithdrawHistoryScreen.routeName: (ctx) =>
              StoreWithdrawHistoryScreen(),
          RiderWithdrawHistoryScreen.routeName: (ctx) =>
              RiderWithdrawHistoryScreen(),
          CustomerOrderScreen.routeName: (ctx) => CustomerOrderScreen(),
          OrderDetailScreen.routeName: (ctx) => OrderDetailScreen(),
          RiderInorderScreen.routeName: (ctx) => RiderInorderScreen(
                orderId: '',
              ),
          RiderOrderDetailScreen.routeName: (ctx) => RiderOrderDetailScreen(),
          RiderConfirmStatusScreen.routeName: (ctx) =>
              RiderConfirmStatusScreen(),
          RiderDeliveryPointScreen.routeName: (ctx) =>
              RiderDeliveryPointScreen(),
          RiderConfirmCustomerOrderScreen.routeName: (ctx) =>
              RiderConfirmCustomerOrderScreen(),
          RiderPaymentHistoryScreen.routeName: (ctx) =>
              RiderPaymentHistoryScreen(),
          StoreOrderScreen.routeName: (ctx) => StoreOrderScreen(),
          StoreOrderTodayScreen.routeName: (ctx) => StoreOrderTodayScreen(),
          StoreOrderTodaySuccessScreen.routeName: (ctx) =>
              StoreOrderTodaySuccessScreen(),
          StoreOrderTodayCancelScreen.routeName: (ctx) =>
              StoreOrderTodayCancelScreen(),
          StoreReportScreen.routeName: (ctx) => StoreReportScreen(),
          EditPostScreen.routeName: (ctx) => EditPostScreen(),
        },
      ),
    );
  }
}
