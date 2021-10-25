import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/model/order_detail.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/screens/customer/order_detail_screen.dart';
import 'package:market_delivery/screens/rider/rider_order_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';

import '../../screens/order/rider_finish_screen.dart';

class RiderWorkScreen extends StatelessWidget {
  static const routeName = "/rider-work-screen";

  Stream<http.Response> getRandomNumberFact({required String rider_id}) async* {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? customerId = await sharedPreferences.getString('customerId');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return http.get(Uri.parse(
          Api.orders + "?rider_id=$rider_id&order_date=$formattedDate"));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    final riderProvider = Provider.of<Riders>(context, listen: false);
    final orderDetail = Provider.of<OrderDetails>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 45,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text('งานของฉัน'),
      ),
      body: Consumer<Orders>(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                child: StreamBuilder<http.Response>(
                                  stream: getRandomNumberFact(
                                      rider_id: riderProvider
                                          .riderModel!.riderId
                                          .toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var results =
                                          jsonDecode(snapshot.data!.body);
                                      // debugPrint(results.toString());
                                      if (results['result'].length > 0) {
                                        orderData.orderByRiderId.clear();
                                        print("Load ++");
                                        for (var item in results['result']) {
                                          orderData.orderByRiderId
                                              .add(Order.fromJson(item));
                                        }
                                        return ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                orderData.orderByRiderId.length,
                                            itemBuilder: (context, i) {
                                              return InkWell(
                                                onTap: () async {
                                                  await orderDetail
                                                      .getOrderDetailByOrderId(
                                                          orderId: orderData
                                                              .orderByRiderId[i]
                                                              .orderId);
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          RiderOrderDetailScreen
                                                              .routeName)
                                                      .then((value) {
                                                    orderDetail
                                                        .resetStateOrderDetails();
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 7),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.blue.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  padding: EdgeInsets.all(12),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'NO. ${orderData.orderByRiderId[i].orderId}',
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
                                                                  .orderByRiderId[
                                                                      i]
                                                                  .storeId
                                                                  .storeName,
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            RichText(
                                                                text: TextSpan(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                    children: [
                                                                  TextSpan(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                    text:
                                                                        'คนส่ง ',
                                                                  ),
                                                                  TextSpan(
                                                                    text: orderData
                                                                        .orderByRiderId[
                                                                            i]
                                                                        .riderId
                                                                        .riderName,
                                                                  )
                                                                ])),
                                                            RichText(
                                                                text: TextSpan(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                    children: [
                                                                  TextSpan(
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blue),
                                                                    text:
                                                                        'คนส่ง ',
                                                                  ),
                                                                  TextSpan(
                                                                    text: orderData
                                                                        .orderByRiderId[
                                                                            i]
                                                                        .customerId
                                                                        .customerName,
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
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                size: 17,
                                                              )),
                                                          orderData
                                                                      .orderByRiderId[
                                                                          i]
                                                                      .status ==
                                                                  '0'
                                                              ? Text(
                                                                  'รอยืนยันคำสั่งซื้อ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : orderData
                                                                          .orderByRiderId[
                                                                              i]
                                                                          .status ==
                                                                      '1'
                                                                  ? Text(
                                                                      'ร้านกำลังเตรียมสินค้า',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .amber
                                                                              .shade900,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : orderData.orderByRiderId[i].status ==
                                                                          '2'
                                                                      ? Text(
                                                                          'กำลังส่ง',
                                                                          style: TextStyle(
                                                                              color: Colors.amber.shade900,
                                                                              fontWeight: FontWeight.bold),
                                                                        )
                                                                      : orderData.orderByRiderId[i].status ==
                                                                              '3'
                                                                          ? Text(
                                                                              'ถึงแล้ว',
                                                                              style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                                                                            )
                                                                          : orderData.orderByRiderId[i].status == '4'
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
                                            child: Text("ไม่มีรายการ"));
                                      }
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
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
    );
  }
}
