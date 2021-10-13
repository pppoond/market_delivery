import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_delivery/model/customer.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/model/order_detail.dart';
import 'package:market_delivery/screens/customer/order_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/order/rider_finish_screen.dart';

class CustomerOrderScreen extends StatelessWidget {
  static const routeName = "/customer-order-screen";

  Stream<http.Response> getRandomNumberFact(
      {required String customerId}) async* {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? customerId = await sharedPreferences.getString('customerId');
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return http.get(Uri.parse(Api.orders + "?customer_id=$customerId"));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<Customers>(context, listen: false);
    final orderDetail = Provider.of<OrderDetails>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                automaticallyImplyLeading: true,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                toolbarHeight: 45,
                elevation: 1,
                centerTitle: true,
                title: Text(
                  'คำสั่งซื้อของฉัน',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                child: Consumer<Orders>(
                  builder: (context, orderData, child) => Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                          child: StreamBuilder<http.Response>(
                                            stream: getRandomNumberFact(
                                                customerId: customerProvider
                                                    .customerModel!.customerId
                                                    .toString()),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                var results = jsonDecode(
                                                    snapshot.data!.body);
                                                // debugPrint(results.toString());
                                                if (results['result'].length >
                                                    0) {
                                                  orderData.orderByCustomerId
                                                      .clear();
                                                  print("Load ++");
                                                  for (var item
                                                      in results['result']) {
                                                    orderData.orderByCustomerId
                                                        .add(Order.fromJson(
                                                            item));
                                                  }
                                                  return ListView.builder(
                                                      physics: ScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: orderData
                                                          .orderByCustomerId
                                                          .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return InkWell(
                                                          onTap: () async {
                                                            await orderDetail
                                                                .getOrderDetailByOrderId(
                                                                    orderId: orderData
                                                                        .orderByCustomerId[
                                                                            i]
                                                                        .orderId);
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    OrderDetailScreen
                                                                        .routeName)
                                                                .then(
                                                                    (value) async {
                                                              await orderDetail
                                                                  .resetStateOrderDetails();
                                                            });
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 7),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .blue
                                                                    .shade100,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'NO. ${orderData.orderByCustomerId[i].orderId}',
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  width: 7,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        orderData
                                                                            .orderByCustomerId[i]
                                                                            .storeId
                                                                            .storeName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                      RichText(
                                                                          text: TextSpan(
                                                                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal),
                                                                              children: [
                                                                            TextSpan(
                                                                              style: TextStyle(color: Colors.blue),
                                                                              text: 'คนส่ง ',
                                                                            ),
                                                                            TextSpan(
                                                                              text: orderData.orderByCustomerId[i].riderId.riderName,
                                                                            )
                                                                          ])),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .arrow_forward_ios,
                                                                          color:
                                                                              Theme.of(context).accentColor,
                                                                          size:
                                                                              17,
                                                                        )),
                                                                    orderData.orderByCustomerId[i].status ==
                                                                            '0'
                                                                        ? Text(
                                                                            'รอยืนยันคำสั่งซื้อ',
                                                                            style:
                                                                                TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                                                          )
                                                                        : orderData.orderByCustomerId[i].status ==
                                                                                '1'
                                                                            ? Text(
                                                                                'ร้านกำลังเตรียมสินค้า',
                                                                                style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold),
                                                                              )
                                                                            : orderData.orderByCustomerId[i].status == '2'
                                                                                ? Text(
                                                                                    'กำลังส่ง',
                                                                                    style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold),
                                                                                  )
                                                                                : orderData.orderByCustomerId[i].status == '3'
                                                                                    ? Text(
                                                                                        'ถึงแล้ว',
                                                                                        style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                                                                                      )
                                                                                    : orderData.orderByCustomerId[i].status == '4'
                                                                                        ? Text(
                                                                                            'รับสินค้าแล้ว',
                                                                                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                                                                          )
                                                                                        : Text(
                                                                                            'ยกเลิก',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                                          )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                } else {
                                                  return Center(
                                                      child: Text(
                                                          "${snapshot.data!.body}"));
                                                }
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
