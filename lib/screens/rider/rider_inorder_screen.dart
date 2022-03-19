import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as map_launcher;
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/model/order_detail.dart';
import 'package:market_delivery/screens/order/rider_result_screen.dart';
import 'package:http/http.dart' as http;
import 'package:market_delivery/screens/rider/rider_confirm_customer_order_screen.dart';
import 'package:market_delivery/screens/rider/rider_confirm_order_status_screen.dart';
import 'package:market_delivery/screens/rider/rider_delivery_point_screen.dart';
import 'package:market_delivery/screens/rider/rider_order_detail_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';

class RiderInorderScreen extends StatelessWidget {
  String orderId;
  RiderInorderScreen({required this.orderId});
  static const routeName = "/rider-inorder-screen";

  Stream<http.Response> getRandomNumberFact({required String orderId}) async* {
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return http.get(Uri.parse(Api.orders + "?findid=$orderId"));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    // String orderId = ModalRoute.of(context)!.settings.arguments as String;
    final orders = Provider.of<Orders>(context, listen: false);
    final orderDetailProvider =
        Provider.of<OrderDetails>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 0,
        elevation: 0,
        title: Text("หน้าหลัก"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder<http.Response>(
                  stream: getRandomNumberFact(orderId: orderId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var results = jsonDecode(snapshot.data!.body);
                      // debugPrint(results.toString());
                      if (results['result'].length > 0) {
                        orders.order = Order.fromJson(results['result'][0]);
                        print(orders.order!.status.toString());

                        switch (orders.order!.status) {
                          case '1':
                            return Scaffold(
                              appBar: AppBar(
                                centerTitle: true,
                                toolbarHeight: 0,
                                elevation: 0,
                                title: Text("หน้าหลัก"),
                              ),
                              body: SafeArea(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      color: Colors.black87,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "รับ",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .green.shade500),
                                                  ),
                                                  Text(
                                                    orders.order!.storeId
                                                        .storeName,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "ส่ง",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .red.shade500),
                                                  ),
                                                  Text(
                                                    orders.order!.customerId
                                                        .customerName,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      color: Theme.of(context).accentColor,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    orders.order!.storeId
                                                        .storeName,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  )),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle),
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        final availableMaps =
                                                            await map_launcher
                                                                .MapLauncher
                                                                .installedMaps;
                                                        if (availableMaps
                                                            .isNotEmpty) {
                                                          await map_launcher
                                                                  .MapLauncher
                                                              .showMarker(
                                                            title: 'Map Google',
                                                            mapType:
                                                                map_launcher
                                                                    .MapType
                                                                    .google,
                                                            coords: map_launcher
                                                                .Coords(
                                                                    orders
                                                                        .order!
                                                                        .addressId
                                                                        .lat,
                                                                    orders
                                                                        .order!
                                                                        .addressId
                                                                        .lng),
                                                          );
                                                        }
                                                      },
                                                      icon: Icon(
                                                          Icons.navigation)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: showMapOrder(
                                            latLng1: LatLng(
                                                orders.order!.storeId.lat,
                                                orders.order!.storeId.lng),
                                            latLng2: LatLng(
                                                orders.order!.addressId.lat,
                                                orders.order!.addressId.lng)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              bottomNavigationBar: SafeArea(
                                child: Container(
                                  color: Colors.black87,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 7),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: TextButton(
                                          onPressed: () async {
                                            await orderDetailProvider
                                                .getOrderDetailByOrderId(
                                                    orderId: orderId);
                                            await Navigator.of(context)
                                                .pushNamed(
                                                    RiderConfirmStatusScreen
                                                        .routeName,
                                                    arguments: orderId);
                                            // await orders.updateOrderStatus(
                                            //     orderId: orderId,
                                            //     orderStatus: '2');
                                          },
                                          style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor:
                                                Theme.of(context).accentColor,
                                            minimumSize: Size(
                                              double.infinity,
                                              50,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            "ฉันมาถึงแล้ว",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.green.shade500),
                                            shape: BoxShape.circle,
                                            // color: Colors.white,
                                            // shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              await orderDetailProvider
                                                  .getOrderDetailByOrderId(
                                                      orderId: orderId);
                                              Navigator.of(context).pushNamed(
                                                  RiderOrderDetailScreen
                                                      .routeName);
                                            },
                                            icon: Icon(
                                              Icons.list_alt,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.green.shade500),
                                            shape: BoxShape.circle,
                                            // color: Colors.white,
                                            // shape: BoxShape.circle,
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    RiderDeliveryPointScreen
                                                        .routeName,
                                                    arguments: orders.order!);
                                              },
                                              child: Text(
                                                "2",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          case '2':
                            return Scaffold(
                              appBar: AppBar(
                                centerTitle: true,
                                toolbarHeight: 0,
                                elevation: 0,
                                title: Text("หน้าหลัก"),
                              ),
                              body: SafeArea(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      color: Colors.black87,
                                      child: Row(
                                        children: [
                                          // Expanded(
                                          //   flex: 5,
                                          //   child: Container(
                                          //     child: Column(
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.start,
                                          //       children: [
                                          //         Text(
                                          //           "รับ",
                                          //           style: TextStyle(
                                          //               fontSize: 17,
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //               color: Colors
                                          //                   .green.shade500),
                                          //         ),
                                          //         Text(
                                          //           orders.order!.storeId
                                          //               .storeName,
                                          //           style: TextStyle(
                                          //               fontSize: 20,
                                          //               fontWeight:
                                          //                   FontWeight.normal,
                                          //               color: Colors.white),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "ส่ง",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .red.shade500),
                                                  ),
                                                  Text(
                                                    orders.order!.customerId
                                                        .customerName,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      color: Theme.of(context).accentColor,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    orders.order!.addressId
                                                        .address,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  )),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle),
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        final availableMaps =
                                                            await map_launcher
                                                                .MapLauncher
                                                                .installedMaps;
                                                        if (availableMaps
                                                            .isNotEmpty) {
                                                          await map_launcher
                                                                  .MapLauncher
                                                              .showMarker(
                                                            title: 'Map Google',
                                                            mapType:
                                                                map_launcher
                                                                    .MapType
                                                                    .google,
                                                            coords: map_launcher
                                                                .Coords(
                                                                    orders
                                                                        .order!
                                                                        .storeId
                                                                        .lat,
                                                                    orders
                                                                        .order!
                                                                        .storeId
                                                                        .lng),
                                                          );
                                                        }
                                                      },
                                                      icon: Icon(
                                                          Icons.navigation)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: showMapOrder2(
                                            latLng2: LatLng(
                                                orders.order!.addressId.lat,
                                                orders.order!.addressId.lng)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              bottomNavigationBar: SafeArea(
                                child: Container(
                                  color: Colors.black87,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 7),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: TextButton(
                                          onPressed: () async {
                                            await orders.updateOrderStatus(
                                                orderId: orderId,
                                                orderStatus: '3');
                                          },
                                          style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor:
                                                Theme.of(context).accentColor,
                                            minimumSize: Size(
                                              double.infinity,
                                              50,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            "ถึงแล้ว",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.green.shade500),
                                            shape: BoxShape.circle,
                                            // color: Colors.white,
                                            // shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              await orderDetailProvider
                                                  .getOrderDetailByOrderId(
                                                      orderId: orderId);
                                              Navigator.of(context).pushNamed(
                                                  RiderOrderDetailScreen
                                                      .routeName);
                                            },
                                            icon: Icon(
                                              Icons.list_alt,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.green.shade500),
                                            shape: BoxShape.circle,
                                            // color: Colors.white,
                                            // shape: BoxShape.circle,
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    RiderDeliveryPointScreen
                                                        .routeName,
                                                    arguments: orders.order!);
                                              },
                                              child: Text(
                                                "2",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          case '3':
                            return Scaffold(
                              appBar: AppBar(
                                centerTitle: true,
                                toolbarHeight: 0,
                                elevation: 0,
                                title: Text("หน้าหลัก"),
                              ),
                              body: SafeArea(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      color: Colors.black87,
                                      child: Row(
                                        children: [
                                          // Expanded(
                                          //   flex: 5,
                                          //   child: Container(
                                          //     child: Column(
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.start,
                                          //       children: [
                                          //         Text(
                                          //           "รับ",
                                          //           style: TextStyle(
                                          //               fontSize: 17,
                                          //               fontWeight:
                                          //                   FontWeight.bold,
                                          //               color: Colors
                                          //                   .green.shade500),
                                          //         ),
                                          //         Text(
                                          //           orders.order!.storeId
                                          //               .storeName,
                                          //           style: TextStyle(
                                          //               fontSize: 20,
                                          //               fontWeight:
                                          //                   FontWeight.normal,
                                          //               color: Colors.white),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "ส่ง",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .red.shade500),
                                                  ),
                                                  Text(
                                                    orders.order!.customerId
                                                        .customerName,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      color: Theme.of(context).accentColor,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 8,
                                                  child: Text(
                                                    orders.order!.addressId
                                                        .address,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  )),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle),
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        final availableMaps =
                                                            await map_launcher
                                                                .MapLauncher
                                                                .installedMaps;
                                                        if (availableMaps
                                                            .isNotEmpty) {
                                                          await map_launcher
                                                                  .MapLauncher
                                                              .showMarker(
                                                            title: 'Map Google',
                                                            mapType:
                                                                map_launcher
                                                                    .MapType
                                                                    .google,
                                                            coords: map_launcher
                                                                .Coords(
                                                                    orders
                                                                        .order!
                                                                        .storeId
                                                                        .lat,
                                                                    orders
                                                                        .order!
                                                                        .storeId
                                                                        .lng),
                                                          );
                                                        }
                                                      },
                                                      icon: Icon(
                                                          Icons.navigation)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: showMapOrder2(
                                            latLng2: LatLng(
                                                orders.order!.addressId.lat,
                                                orders.order!.addressId.lng)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              bottomNavigationBar: SafeArea(
                                child: Container(
                                  color: Colors.black87,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 7),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: TextButton(
                                          onPressed: () async {
                                            Navigator.of(context).pushNamed(
                                                RiderConfirmCustomerOrderScreen
                                                    .routeName,
                                                arguments:
                                                    orders.order!.orderId);
                                          },
                                          style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor:
                                                Theme.of(context).accentColor,
                                            minimumSize: Size(
                                              double.infinity,
                                              50,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            "ส่งสินค้า",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.green.shade500),
                                            shape: BoxShape.circle,
                                            // color: Colors.white,
                                            // shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              await orderDetailProvider
                                                  .getOrderDetailByOrderId(
                                                      orderId: orderId);
                                              Navigator.of(context).pushNamed(
                                                  RiderOrderDetailScreen
                                                      .routeName);
                                            },
                                            icon: Icon(
                                              Icons.list_alt,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.green.shade500),
                                            shape: BoxShape.circle,
                                            // color: Colors.white,
                                            // shape: BoxShape.circle,
                                          ),
                                          child: TextButton(
                                              onPressed: () async {
                                                await orderDetailProvider
                                                    .getOrderDetailByOrderId(
                                                        orderId: orderId);
                                                Navigator.of(context).pushNamed(
                                                    RiderDeliveryPointScreen
                                                        .routeName,
                                                    arguments: orders.order!);
                                              },
                                              child: Text(
                                                "2",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          default:
                            return Center(
                                child: Text("${snapshot.data!.body}"));
                        }
                      } else {
                        return Center(child: Text("${snapshot.data!.body}"));
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
      ),
    );
  }

  Container showMapOrder({required LatLng latLng1, required LatLng latLng2}) {
//     GoogleMapController _controller =   GoogleMapController();
//     // the bounds you want to set
//     LatLngBounds bounds = LatLngBounds(
//       southwest: LatLng(latLng1.latitude, latLng1.longitude),
//       northeast: LatLng(latLng2.latitude, latLng2.longitude),
//     );
// // calculating centre of the bounds
//     LatLng centerBounds = LatLng(
//         (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
//         (bounds.northeast.longitude + bounds.southwest.longitude) / 2);

// // setting map position to centre to start with
//     _controller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       target: centerBounds,
//       zoom: 17,
//     )));
//     zoomToFit(_controller, bounds, centerBounds);

    LatLng latLng = LatLng(16.20144295022659, 103.28276975227374);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng1,
      zoom: 12.0,
    );
    return Container(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (controller) {},
        markers: {
          // if (customerData.lat != null)
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(latLng1.latitude, latLng1.longitude),
            // infoWindow: InfoWindow(
            //     title: "สนามบินสุวรรณภูมิ",
            //     snippet: "สนามบินนานาชาติของประเทศไทย"),
          ),
          Marker(
            markerId: MarkerId("2"),
            position: LatLng(latLng2.latitude, latLng2.longitude),
            // infoWindow: InfoWindow(
            //     title: "สนามบินสุวรรณภูมิ",
            //     snippet: "สนามบินนานาชาติของประเทศไทย"),
          ),
        },
      ),
    );
  }

  Container showMapOrder2({required LatLng latLng2}) {
//     GoogleMapController _controller =   GoogleMapController();
//     // the bounds you want to set
//     LatLngBounds bounds = LatLngBounds(
//       southwest: LatLng(latLng1.latitude, latLng1.longitude),
//       northeast: LatLng(latLng2.latitude, latLng2.longitude),
//     );
// // calculating centre of the bounds
//     LatLng centerBounds = LatLng(
//         (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
//         (bounds.northeast.longitude + bounds.southwest.longitude) / 2);

// // setting map position to centre to start with
//     _controller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       target: centerBounds,
//       zoom: 17,
//     )));
//     zoomToFit(_controller, bounds, centerBounds);

    LatLng latLng = LatLng(16.20144295022659, 103.28276975227374);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng2,
      zoom: 12.0,
    );
    return Container(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (controller) {},
        markers: {
          Marker(
            markerId: MarkerId("2"),
            position: LatLng(latLng2.latitude, latLng2.longitude),
            // infoWindow: InfoWindow(
            //     title: "สนามบินสุวรรณภูมิ",
            //     snippet: "สนามบินนานาชาติของประเทศไทย"),
          ),
        },
      ),
    );
  }
}
