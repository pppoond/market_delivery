import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/model/order_detail.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/screens/rider/rider_order_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../screens/order/rider_finish_screen.dart';

class RiderIncome extends StatelessWidget {
  Stream<http.Response> getRandomNumberFact(
      {required String rider_id, required BuildContext context}) async* {
    final riderProvider = Provider.of<Riders>(context, listen: false);
    final orderDetail = Provider.of<OrderDetails>(context, listen: false);
    final orderProvider = Provider.of<Orders>(context, listen: false);
    // riderProvider.updateLatLng();
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? customerId = await sharedPreferences.getString('customerId');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    orderProvider.todayIncome = 0.0;
    yield* Stream.periodic(Duration(seconds: 5), (_) async {
      var response = await http.get(
          Uri.parse(Api.orders + "?rider_id=$rider_id&order_date=2021-10-07"));
      var results = jsonDecode(response.body);
      for (var item in results['result']) {
        orderProvider.todayIncome += double.parse(item['total']);
      }
      orderProvider.notifyListeners();
      return response;
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    final riderProvider = Provider.of<Riders>(context, listen: false);
    final orderDetail = Provider.of<OrderDetails>(context, listen: false);
    final orderProvider = Provider.of<Orders>(context, listen: false);
    orderProvider.getOrderByRiderId();
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height: 125,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    elevation: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "รายได้วันนี้",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Consumer<Orders>(
                              builder: (context, data, child) => Text(
                                '฿' + data.totalTodayIncome.toString(),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "รายได้ทั้งหมด",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Consumer<Orders>(
                              builder: (context, data, child) => Text(
                                '฿' + data.totalRiderIncomeAll.toString(),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     color: Colors.grey.shade200,
          //     elevation: 0,
          //     child: InkWell(
          //       onTap: () {
          //         Navigator.of(context).pushNamed(RiderFinishScreen.routeName);
          //       },
          //       child: Padding(
          //         padding: EdgeInsets.all(12),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "ทำรายการเสร็จสมบูรณ์",
          //                   style: TextStyle(fontSize: 17),
          //                 ),
          //                 Spacer(),
          //                 Icon(
          //                   Icons.arrow_forward_ios,
          //                   size: 16,
          //                 )
          //               ],
          //             ),
          //             Text(
          //               "0 รายการ",
          //               style: TextStyle(
          //                   fontSize: 20, fontWeight: FontWeight.bold),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          Consumer<Orders>(
            builder: (context, orderData, child) => Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: StreamBuilder<http.Response>(
                stream: getRandomNumberFact(
                    context: context,
                    rider_id: riderProvider.riderModel!.riderId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var results = jsonDecode(snapshot.data!.body);
                    // debugPrint(results.toString());
                    if (results['result'].length > 0) {
                      orderData.orderByRiderId.clear();
                      print("Load ++");
                      for (var item in results['result']) {
                        orderData.orderByRiderId.add(Order.fromJson(item));
                      }

                      return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: orderData.orderByRiderId.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () async {
                                await orderDetail.getOrderDetailByOrderId(
                                    orderId:
                                        orderData.orderByRiderId[i].orderId);
                                Navigator.of(context)
                                    .pushNamed(RiderOrderDetailScreen.routeName)
                                    .then((value) {
                                  orderDetail.resetStateOrderDetails();
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 7),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(12)),
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Text(
                                      '${orderData.orderByRiderId[i].orderId}',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            orderData.orderByRiderId[i].storeId
                                                .storeName,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  children: [
                                                TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                  text: 'คนส่ง ',
                                                ),
                                                TextSpan(
                                                  text: orderData
                                                      .orderByRiderId[i]
                                                      .riderId
                                                      .riderName,
                                                )
                                              ])),
                                          RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  children: [
                                                TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                  text: 'คนส่ง ',
                                                ),
                                                TextSpan(
                                                  text: orderData
                                                      .orderByRiderId[i]
                                                      .customerId
                                                      .customerName,
                                                )
                                              ])),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                            '฿ ${orderData.orderByRiderId[i].total}'),
                                        orderData.orderByRiderId[i].status ==
                                                '0'
                                            ? Text(
                                                'รอยืนยันคำสั่งซื้อ',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : orderData.orderByRiderId[i]
                                                        .status ==
                                                    '1'
                                                ? Text(
                                                    'ร้านกำลังเตรียมสินค้า',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .amber.shade900,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : orderData.orderByRiderId[i]
                                                            .status ==
                                                        '2'
                                                    ? Text(
                                                        'กำลังส่ง',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .amber.shade900,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    : orderData
                                                                .orderByRiderId[
                                                                    i]
                                                                .status ==
                                                            '3'
                                                        ? Text(
                                                            'ถึงแล้ว',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue
                                                                    .shade900,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        : orderData
                                                                    .orderByRiderId[
                                                                        i]
                                                                    .status ==
                                                                '4'
                                                            ? Text(
                                                                'รับสินค้าแล้ว',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                'ยกเลิก',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(child: Text("ไม่มีรายการ"));
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
