import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:market_delivery/model/customer.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/model/order_detail.dart';
import 'package:market_delivery/model/store.dart';
import 'package:market_delivery/screens/customer/order_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../screens/order/rider_finish_screen.dart';

class StoreReportScreen extends StatelessWidget {
  static const routeName = "/store-report-screen";

  Stream<http.Response> getRandomNumberFact({required String storeId}) async* {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? customerId = await sharedPreferences.getString('customerId');
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return http.get(Uri.parse(Api.orders + "?store_id=$storeId"));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<Stores>(context, listen: false);
    final customerProvider = Provider.of<Customers>(context, listen: false);
    final orderDetail = Provider.of<OrderDetails>(context, listen: false);
    final orderProvider = Provider.of<Orders>(context, listen: false);
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
                  'รายงาน',
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
                                            child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              // Padding(
                                              //   padding: EdgeInsets.all(0),
                                              //   child: AspectRatio(
                                              //     aspectRatio: 16 / 9,
                                              //     child: DChartLine(
                                              //       includeArea: true,
                                              //       data: [
                                              //         {
                                              //           'id': 'Line',
                                              //           'data': [
                                              //             {
                                              //               'domain': 0,
                                              //               'measure': 4.1
                                              //             },
                                              //             {
                                              //               'domain': 1,
                                              //               'measure': 4
                                              //             },
                                              //             {
                                              //               'domain': 2,
                                              //               'measure': 6
                                              //             },
                                              //             {
                                              //               'domain': 3,
                                              //               'measure': 1
                                              //             },
                                              //             {
                                              //               'domain': 4,
                                              //               'measure': 12
                                              //             },
                                              //             {
                                              //               'domain': 5,
                                              //               'measure': 4
                                              //             },
                                              //             {
                                              //               'domain': 6,
                                              //               'measure': 3
                                              //             }
                                              //           ],
                                              //         },
                                              //       ],
                                              //       lineColor:
                                              //           (lineData, index, id) =>
                                              //               Colors.amber,
                                              //     ),
                                              //   ),
                                              // ),
                                              Container(
                                                child: Consumer<Orders>(
                                                  builder:
                                                      (context, data, child) =>
                                                          SfCartesianChart(
                                                    title: ChartTitle(
                                                        text:
                                                            'รายงานยอดขายประจำวัน'),
                                                    legend:
                                                        Legend(isVisible: true),
                                                    tooltipBehavior:
                                                        TooltipBehavior(
                                                            enable: true),
                                                    series: <ChartSeries>[
                                                      BarSeries<GDPData,
                                                              String>(
                                                          name: 'ออเดอร์',
                                                          dataSource:
                                                              getChartData(),
                                                          xValueMapper:
                                                              (GDPData gdp,
                                                                      _) =>
                                                                  gdp.continent,
                                                          yValueMapper:
                                                              (GDPData gdp,
                                                                      _) =>
                                                                  gdp.gdp,
                                                          dataLabelSettings:
                                                              DataLabelSettings(
                                                                  isVisible:
                                                                      true),
                                                          enableTooltip: true)
                                                    ],
                                                    primaryXAxis:
                                                        CategoryAxis(),
                                                    primaryYAxis: NumericAxis(
                                                        edgeLabelPlacement:
                                                            EdgeLabelPlacement
                                                                .shift,
                                                        // numberFormat: NumberFormat
                                                        //     .simpleCurrency(
                                                        //         decimalDigits:
                                                        //             0),
                                                        title: AxisTitle(
                                                            text: 'ออเดอร์')),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    DatePicker.showDatePicker(
                                                        context,
                                                        showTitleActions: true,
                                                        minTime: DateTime(
                                                            2020, 3, 5),
                                                        maxTime: DateTime.now(),
                                                        onChanged: (date) {
                                                      print('change $date');
                                                    }, onConfirm: (date) {
                                                      print('confirm $date');
                                                      orderProvider.dateTime =
                                                          date;
                                                      orderProvider
                                                          .getOrderByStoreDate();
                                                    },
                                                        currentTime:
                                                            DateTime.now(),
                                                        locale: LocaleType.th);
                                                  },
                                                  child: Text(
                                                    'เลือกวันที่',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ))
                                            ],
                                          ),
                                        )),
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

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('ยอดขายวันนี้', 28),
      GDPData('สำเร็จ', 26),
      GDPData('ยกเลิก', 1),
      GDPData('กำลังดำเนินการ', 1),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final double gdp;
}
