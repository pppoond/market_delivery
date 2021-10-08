// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:market_delivery/utils/api.dart';

// class StreamApiScreen extends StatelessWidget {
//   Stream<http.Response> getRandomNumberFact() async* {
//     yield* Stream.periodic(Duration(seconds: 1), (_) {
//       return http.get(Uri.parse(Api.customer));
//     }).asyncMap((event) async => await event);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child: StreamBuilder<http.Response>(
//           stream: getRandomNumberFact(),
//           builder: (context, snapshot) {
//             if (snapshot.data!.body != null) {
//               // dynamic jsonString = jsonEncode(snapshot.data!.body);
//               dynamic jsonData = jsonDecode(snapshot.data!.body);
//               print(jsonData['result'].toString());
//               // var result = jsonData['result'];

//               return Center(
//                   child: ListView(
//                 children: [
//                   ListView.builder(
//                     physics: ScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: jsonData['result'].length > 0
//                         ? jsonData['result'].length
//                         : 0,
//                     itemBuilder: (context, i) {
//                       return Card(
//                         child: Text(jsonData['result'][i]['username']),
//                       );
//                     },
//                   ),
//                   Text(
//                     snapshot.data!.body,
//                     style: TextStyle(color: Colors.green, fontSize: 17),
//                   ),
//                 ],
//               ));
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// import 'package:market_delivery/utils/api.dart';

// class StreamApiScreen extends StatefulWidget {
//   @override
//   _StreamApiScreenState createState() => new _StreamApiScreenState();
// }

// class _StreamApiScreenState extends State<StreamApiScreen> {
//   late StreamController _postsController;
//   final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

//   int count = 1;

//   Future fetchPost() async {
//     final response = await http.get(Uri.parse(Api.customer));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load post');
//     }
//   }

//   loadPosts() async {
//     fetchPost().then((res) async {
//       _postsController.add(res);
//       return res;
//     });
//   }

//   showSnack() {
//     return scaffoldKey.currentState!.showSnackBar(
//       SnackBar(
//         content: Text('New content loaded'),
//       ),
//     );
//   }

//   Future<Null> _handleRefresh() async {
//     count++;
//     print(count);
//     fetchPost().then((res) async {
//       _postsController.add(res);
//       showSnack();
//       return null;
//     });
//   }

//   @override
//   void initState() {
//     _postsController = new StreamController();
//     loadPosts();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: scaffoldKey,
//       appBar: new AppBar(
//         title: new Text('StreamBuilder'),
//         actions: <Widget>[
//           IconButton(
//             tooltip: 'Refresh',
//             icon: Icon(Icons.refresh),
//             onPressed: _handleRefresh,
//           )
//         ],
//       ),
//       body: StreamBuilder(
//         stream: _postsController.stream,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           print('Has error: ${snapshot.hasError}');
//           print('Has data: ${snapshot.hasData}');
//           print('Snapshot Data ${snapshot.data}');

//           if (snapshot.hasError) {
//             return Text(snapshot.error.toString());
//           } else if (snapshot.hasData) {
//             return Column(
//               children: <Widget>[
//                 Expanded(
//                   child: Scrollbar(
//                     child: RefreshIndicator(
//                       onRefresh: _handleRefresh,
//                       child: ListView.builder(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         itemCount: snapshot.data['result'].length,
//                         itemBuilder: (context, index) {
//                           var post = snapshot.data['result'][index];
//                           return ListTile(
//                             title: Text(""),
//                             subtitle: Text(post['username']),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           } else if (snapshot.connectionState != ConnectionState.done) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (!snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.done) {
//             return Text('No Posts');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// import 'package:market_delivery/utils/api.dart';
// import 'package:provider/provider.dart';

// import '../model/order.dart';
// import '../model/rider.dart';

// class StreamApiScreen extends StatelessWidget {
//   Stream<http.Response> getRandomNumberFact({required String riderId}) async* {
//     yield* Stream.periodic(Duration(seconds: 1), (_) {
//       return http
//           .get(Uri.parse(Api.orders + "?rider_id=$riderId&order_status=0"));
//     }).asyncMap((event) async => await event);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orders = Provider.of<Orders>(context, listen: false);
//     final riderProvider = Provider.of<Riders>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         child: StreamBuilder<http.Response>(
//           stream:
//               getRandomNumberFact(riderId: riderProvider.riderModel!.riderId),
//           builder: (context, snapshot) {
//             dynamic jsonData = jsonDecode(snapshot.data!.body);
//             if (jsonData['result'] != null) {
//               // dynamic jsonString = jsonEncode(snapshot.data!.body);

//               print(jsonData['result'].toString());
//               var result = jsonData['result'];
//               if (result[0]['status'] == "0") {
//                 return Scaffold(
//                   appBar: AppBar(
//                     automaticallyImplyLeading: false,
//                     title: Text(
//                       "มีคำสั่งซื้อ",
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     centerTitle: true,
//                     toolbarHeight: 45,
//                     backgroundColor: Theme.of(context).accentColor,
//                     elevation: 0,
//                     actions: [
//                       IconButton(
//                         onPressed: () {
//                           // setState(() {
//                           //   noOrder = !noOrder;
//                           // });
//                         },
//                         icon: Icon(
//                           Icons.close,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   body: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         child: showMapOrder(),
//                       ),
//                       SizedBox(
//                         height: 7,
//                       ),
//                       Container(
//                         child: Center(
//                           child: Column(
//                             children: [
//                               Text(
//                                 "THB",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Text("15",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 22,
//                                   )),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 7, vertical: 3),
//                                 decoration: BoxDecoration(
//                                     color: Theme.of(context).accentColor,
//                                     borderRadius: BorderRadius.circular(7)),
//                                 child: Text(
//                                   "ค่าโดยสาร",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 7,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(7),
//                                       border: Border.all(
//                                           width: 1,
//                                           color: Theme.of(context).accentColor,
//                                           style: BorderStyle.solid)),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey.shade200,
//                                           borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(7),
//                                               topRight: Radius.circular(7)),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 8.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceAround,
//                                             children: [
//                                               Text("ระยะทาง 0.5 KM"),
//                                               Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 7, vertical: 3),
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.grey.shade300,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             7)),
//                                                 child: Text(
//                                                   "เงินสด",
//                                                   style: TextStyle(),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 8.0),
//                                           child: Center(
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 Text(
//                                                   "ร้านผลไม้",
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                                 Text(
//                                                     "ตลาดสดเทสบาล อ.เมือง จ.มหาสารคาม"),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey.shade200,
//                                           borderRadius: BorderRadius.only(
//                                               bottomLeft: Radius.circular(7),
//                                               bottomRight: Radius.circular(7)),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: 8.0),
//                                           child: Center(
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 Text(
//                                                   "Maha Village",
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                                 Text(
//                                                     "บ้านเลขที่ 71/3\nถนนนครสวรร ซ.17 อ.เมือง จ.มหาสารคาม"),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   bottomNavigationBar: SafeArea(
//                     child: Padding(
//                       padding: EdgeInsets.all(20.0),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: TextButton(
//                               onPressed: () {
//                                 orders.getOrder();
//                               },
//                               style: TextButton.styleFrom(
//                                 primary: Colors.white,
//                                 backgroundColor: Theme.of(context).accentColor,
//                                 minimumSize: Size(
//                                   double.infinity,
//                                   50,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: Text(
//                                 "รับคำสั่งซื้อ",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(
//                     child: ListView(
//                   children: [
//                     ListView.builder(
//                       physics: ScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: jsonData['result'].length > 0
//                           ? jsonData['result'].length
//                           : 0,
//                       itemBuilder: (context, i) {
//                         return Card(
//                           child: Text(jsonData['result'][i]['store_id']),
//                         );
//                       },
//                     ),
//                     Text(
//                       snapshot.data!.body,
//                       style: TextStyle(color: Colors.green, fontSize: 17),
//                     ),
//                   ],
//                 ));
//               }
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Container showMapOrder() {
//     LatLng latLng = LatLng(16.20144295022659, 103.28276975227374);
//     CameraPosition cameraPosition = CameraPosition(
//       target: latLng,
//       zoom: 16.0,
//     );
//     return Container(
//       child: GoogleMap(
//         initialCameraPosition: cameraPosition,
//         mapType: MapType.normal,
//         zoomControlsEnabled: false,
//         onMapCreated: (controller) {},
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:market_delivery/utils/api.dart';
import 'package:market_delivery/utils/calculate_distance.dart';
import 'package:provider/provider.dart';

import '../model/order.dart';
import '../model/rider.dart';

class StreamApiScreen extends StatelessWidget {
  Stream<http.Response> getRandomNumberFact({required String riderId}) async* {
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return http
          .get(Uri.parse(Api.orders + "?rider_id=$riderId&order_status=0"));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context, listen: false);
    final riderProvider = Provider.of<Riders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 45,
      ),
      body: Container(
        child: StreamBuilder<http.Response>(
          stream:
              getRandomNumberFact(riderId: riderProvider.riderModel!.riderId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var results = jsonDecode(snapshot.data!.body);
              // debugPrint(results.toString());
              if (results['result'].length > 0) {
                orders.order = Order.fromJson(results['result'][0]);
                print(orders.order!.status.toString());

                switch (orders.order!.status) {
                  case '0':
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        title: Text(
                          "มีคำสั่งซื้อ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        centerTitle: true,
                        toolbarHeight: 45,
                        backgroundColor: Theme.of(context).accentColor,
                        elevation: 0,
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: showMapOrder(
                                latLng1: LatLng(riderProvider.riderModel!.lat,
                                    riderProvider.riderModel!.lng),
                                latLng2: LatLng(orders.order!.addressId.lat,
                                    orders.order!.addressId.lng)),
                          ),
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "THB",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("15",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        )),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Text(
                                        "ค่าโดยสาร",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                style: BorderStyle.solid)),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(7),
                                                    topRight:
                                                        Radius.circular(7)),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text("ระยะทางไปร้าน " +
                                                        CalculateDistance
                                                                .calDistanceLatLng(
                                                                    lat1: orders
                                                                        .order!
                                                                        .riderId
                                                                        .lat,
                                                                    lng1:
                                                                        orders
                                                                            .order!
                                                                            .riderId
                                                                            .lng,
                                                                    lat2: orders
                                                                        .order!
                                                                        .storeId
                                                                        .lat,
                                                                    lng2: orders
                                                                        .order!
                                                                        .storeId
                                                                        .lng)
                                                            .toString() +
                                                        " Km"),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 7,
                                                              vertical: 3),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .blue.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7)),
                                                      child: orders.order!
                                                                  .cashMethod ==
                                                              '1'
                                                          ? Text(
                                                              "เงินสด",
                                                              style:
                                                                  TextStyle(),
                                                            )
                                                          : Text(
                                                              "พร้อมเพย์",
                                                              style:
                                                                  TextStyle(),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        orders.order!.storeId
                                                            .storeName,
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                          orders.order!.storeId
                                                              .storePhone,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(7),
                                                    bottomRight:
                                                        Radius.circular(7)),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        orders.order!.customerId
                                                            .customerName,
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        orders.order!.addressId
                                                            .address,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54),
                                                      ),
                                                    ],
                                                  ),
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
                          )
                        ],
                      ),
                      bottomNavigationBar: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    minimumSize: Size(
                                      double.infinity,
                                      50,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "รับคำสั่งซื้อ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  case '1':
                    return Center(child: Text("STATUS 1"));
                  default:
                    return Center(child: Text("${snapshot.data!.body}"));
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
      zoom: 15.0,
    );
    return Container(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
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

//   Future<void> zoomToFit(GoogleMapController controller, LatLngBounds bounds,
//       LatLng centerBounds) async {
//     bool keepZoomingOut = true;

//     while (keepZoomingOut) {
//       final LatLngBounds screenBounds = await controller.getVisibleRegion();
//       if (fits(bounds, screenBounds)) {
//         keepZoomingOut = false;
//         final double zoomLevel = await controller.getZoomLevel() - 0.5;
//         controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
//           target: centerBounds,
//           zoom: zoomLevel,
//         )));
//         break;
//       } else {
//         // Zooming out by 0.1 zoom level per iteration
//         final double zoomLevel = await controller.getZoomLevel() - 0.1;
//         controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
//           target: centerBounds,
//           zoom: zoomLevel,
//         )));
//       }
//     }
//   }

//   bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
//     final bool northEastLatitudeCheck =
//         screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
//     final bool northEastLongitudeCheck =
//         screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

//     final bool southWestLatitudeCheck =
//         screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
//     final bool southWestLongitudeCheck =
//         screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

//     return northEastLatitudeCheck &&
//         northEastLongitudeCheck &&
//         southWestLatitudeCheck &&
//         southWestLongitudeCheck;
//   }
}
