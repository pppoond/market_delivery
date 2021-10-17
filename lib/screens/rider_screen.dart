// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:market_delivery/screens/order/rider_result_screen.dart';

// import 'package:provider/provider.dart';

// import '../widgets/drawer/rider_drawer.dart';
// import './stream_api_screen.dart';

// import 'package:market_delivery/widgets/order/rider_order_modal.dart';

// import '../model/rider.dart';

// class RiderScreen extends StatefulWidget {
//   static const routeName = "/rider-screen";

//   @override
//   State<RiderScreen> createState() => _RiderScreenState();
// }

// class _RiderScreenState extends State<RiderScreen> {
//   bool isOffline = true;
//   bool noOrder = true;
//   bool inOrder = false;
//   bool detailList = false;
//   int status = 1;
//   bool inResult = false;
//   bool isShowLocation = false;
//   @override
//   Widget build(BuildContext context) {
//     final riderProvider = Provider.of<Riders>(context, listen: false);
//     riderProvider.findById();
//     return Stack(
//       children: [
//         (inOrder)
//             ? showInOrder()
//             : (noOrder)
//                 ? Scaffold(
//                     drawer: Drawer(
//                       child: SafeArea(child: RiderDrawer()),
//                     ),
//                     appBar: AppBar(
//                       centerTitle: true,
//                       toolbarHeight: 45,
//                       elevation: 1,
//                       title: Text("หน้าหลัก"),
//                       actions: [
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               noOrder = !noOrder;
//                             });
//                           },
//                           icon: Icon(Icons.notifications_none),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => StreamApiScreen()));
//                           },
//                           icon: Icon(Icons.notifications_none),
//                         ),
//                       ],
//                     ),
//                     body: Container(
//                       child: Stack(
//                         fit: StackFit.expand,
//                         alignment: Alignment.center,
//                         children: [
//                           showMap(),
//                           Align(
//                               alignment: Alignment.bottomCenter,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.2,
//                                   width: double.maxFinite,
//                                   color: Colors.transparent,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             isOffline = !isOffline;
//                                           });
//                                           // RiderOrderModal.showModal(
//                                           //     ctx: context, orderId: "1");
//                                         },
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: (isOffline)
//                                                 ? Colors.black
//                                                 : Colors.green.shade500,
//                                             borderRadius:
//                                                 BorderRadius.circular(30),
//                                           ),
//                                           padding: EdgeInsets.all(16),
//                                           child: (isOffline)
//                                               ? Text(
//                                                   "ออนไลน์",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 17,
//                                                       color: Colors.white),
//                                                 )
//                                               : Text(
//                                                   "ออฟไลน์",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 17,
//                                                       color: Colors.white),
//                                                 ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 7,
//                                       ),
//                                       Material(
//                                         elevation: 2,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                           ),
//                                           padding: EdgeInsets.all(16),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 "สถานะ",
//                                                 style: TextStyle(
//                                                   fontSize: 17,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 7,
//                                               ),
//                                               (isOffline)
//                                                   ? Text(
//                                                       "ออฟไลน์",
//                                                       style: TextStyle(
//                                                         fontSize: 17,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     )
//                                                   : Text(
//                                                       "ออนไลน์",
//                                                       style: TextStyle(
//                                                         fontSize: 17,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: Colors
//                                                             .green.shade500,
//                                                       ),
//                                                     )
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ))
//                         ],
//                       ),
//                     ),
//                   )
//                 : Scaffold(
//                     appBar: AppBar(
//                       automaticallyImplyLeading: false,
//                       title: Text(
//                         "มีคำสั่งซื้อ",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       centerTitle: true,
//                       toolbarHeight: 45,
//                       backgroundColor: Theme.of(context).accentColor,
//                       elevation: 0,
//                       actions: [
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               noOrder = !noOrder;
//                             });
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                     body: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.3,
//                           child: showMapOrder(),
//                         ),
//                         SizedBox(
//                           height: 7,
//                         ),
//                         Container(
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "THB",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text("15",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 22,
//                                     )),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 7, vertical: 3),
//                                   decoration: BoxDecoration(
//                                       color: Theme.of(context).accentColor,
//                                       borderRadius: BorderRadius.circular(7)),
//                                   child: Text(
//                                     "ค่าโดยสาร",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 7,
//                                 ),
//                                 Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 16.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(7),
//                                         border: Border.all(
//                                             width: 1,
//                                             color:
//                                                 Theme.of(context).accentColor,
//                                             style: BorderStyle.solid)),
//                                     child: Column(
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.shade200,
//                                             borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(7),
//                                                 topRight: Radius.circular(7)),
//                                           ),
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 8.0),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 Text("ระยะทาง 0.5 KM"),
//                                                 Container(
//                                                   padding: EdgeInsets.symmetric(
//                                                       horizontal: 7,
//                                                       vertical: 3),
//                                                   decoration: BoxDecoration(
//                                                       color:
//                                                           Colors.grey.shade300,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               7)),
//                                                   child: Text(
//                                                     "เงินสด",
//                                                     style: TextStyle(),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                           ),
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 8.0),
//                                             child: Center(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   Text(
//                                                     "ร้านผลไม้",
//                                                     style: TextStyle(
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   Text(
//                                                       "ตลาดสดเทสบาล อ.เมือง จ.มหาสารคาม"),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.shade200,
//                                             borderRadius: BorderRadius.only(
//                                                 bottomLeft: Radius.circular(7),
//                                                 bottomRight:
//                                                     Radius.circular(7)),
//                                           ),
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 8.0),
//                                             child: Center(
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   Text(
//                                                     "Maha Village",
//                                                     style: TextStyle(
//                                                         fontSize: 20,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   Text(
//                                                       "บ้านเลขที่ 71/3\nถนนนครสวรร ซ.17 อ.เมือง จ.มหาสารคาม"),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     bottomNavigationBar: SafeArea(
//                       child: Padding(
//                         padding: EdgeInsets.all(20.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     inOrder = !inOrder;
//                                   });
//                                 },
//                                 style: TextButton.styleFrom(
//                                   primary: Colors.white,
//                                   backgroundColor:
//                                       Theme.of(context).accentColor,
//                                   minimumSize: Size(
//                                     double.infinity,
//                                     50,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   "รับคำสั่งซื้อ",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//         if (detailList) showListOrder(),
//         if (isShowLocation) showLocationDetail(),
//       ],
//     );
//   }

//   Container showMap() {
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

//   Scaffold showInOrder() {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 0,
//         backgroundColor: Theme.of(context).accentColor,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(16),
//               color: Colors.black87,
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 5,
//                     child: Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "รับ",
//                             style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green.shade500),
//                           ),
//                           Text(
//                             "ร้านผลไม้",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Container(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "ส่ง",
//                             style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red.shade500),
//                           ),
//                           Text(
//                             "Maha Village",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(16),
//               color: Theme.of(context).accentColor,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                           flex: 8,
//                           child: Text(
//                             "ร้านผลไม้\nตลาดสดเทสบาล อ.เมือง จ.มหาสารคาม",
//                             style: TextStyle(fontSize: 17, color: Colors.white),
//                           )),
//                       Expanded(
//                         flex: 2,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white, shape: BoxShape.circle),
//                           child: IconButton(
//                               onPressed: () {}, icon: Icon(Icons.navigation)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 child: showMapOrder(),
//               ),
//             )
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           color: Colors.black87,
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 7),
//           child: Row(
//             children: [
//               if (status == 1)
//                 Expanded(
//                   flex: 6,
//                   child: TextButton(
//                     onPressed: () {
//                       setState(() {
//                         status = 2;
//                       });
//                     },
//                     style: TextButton.styleFrom(
//                       primary: Colors.white,
//                       backgroundColor: Theme.of(context).accentColor,
//                       minimumSize: Size(
//                         double.infinity,
//                         50,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "ฉันมาถึงแล้ว",
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 )
//               else if (status == 2)
//                 Expanded(
//                     flex: 6,
//                     child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           status = 3;
//                         });
//                       },
//                       style: TextButton.styleFrom(
//                         primary: Colors.white,
//                         backgroundColor: Colors.white,
//                         minimumSize: Size(
//                           double.infinity,
//                           50,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text("รับของแล้ว",
//                           style: TextStyle(
//                               fontSize: 18, color: Colors.green.shade500)),
//                     ))
//               else if (status == 3)
//                 Expanded(
//                     flex: 6,
//                     child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           status = 4;
//                         });
//                       },
//                       style: TextButton.styleFrom(
//                         primary: Colors.white,
//                         backgroundColor: Colors.white,
//                         minimumSize: Size(
//                           double.infinity,
//                           50,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text("ถึงแล้ว",
//                           style: TextStyle(
//                               fontSize: 18, color: Colors.green.shade500)),
//                     ))
//               else
//                 Expanded(
//                     flex: 6,
//                     child: TextButton(
//                       onPressed: () {
//                         // setState(() {
//                         //   inOrder = !inOrder;
//                         //   noOrder = !noOrder;
//                         // });
//                         // status = 1;
//                         Navigator.of(context)
//                             .pushNamed(RiderResultScreen.routeName);
//                       },
//                       style: TextButton.styleFrom(
//                         primary: Colors.white,
//                         backgroundColor: Theme.of(context).accentColor,
//                         minimumSize: Size(
//                           double.infinity,
//                           50,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text("ส่ง",
//                           style: TextStyle(
//                             fontSize: 18,
//                           )),
//                     )),
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.green.shade500),
//                     shape: BoxShape.circle,
//                     // color: Colors.white,
//                     // shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         detailList = !detailList;
//                       });
//                     },
//                     icon: Icon(
//                       Icons.list_alt,
//                       size: 30,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.green.shade500),
//                     shape: BoxShape.circle,
//                     // color: Colors.white,
//                     // shape: BoxShape.circle,
//                   ),
//                   child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           isShowLocation = !isShowLocation;
//                         });
//                       },
//                       child: Text(
//                         "2",
//                         style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       )),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Scaffold showListOrder() {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 45,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "รายละเอียดคำสั่งซื้อ",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Theme.of(context).accentColor,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   detailList = !detailList;
//                 });
//               },
//               icon: Icon(
//                 Icons.close,
//                 color: Colors.white,
//               ))
//         ],
//       ),
//       body: SafeArea(
//           child: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         children: [
//           SizedBox(
//             height: 7,
//           ),
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "คำสั่งซื้อ TL123",
//                   style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 Text(
//                   "จาก ร้านผลไม้",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 7,
//           ),
//           ListView.builder(
//             itemCount: 2,
//             physics: ScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return Container(
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           "เงาะ",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                         Spacer(),
//                         Text(
//                           "฿30 x 1",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         )
//                       ],
//                     ),
//                     Divider(),
//                   ],
//                 ),
//               );
//             },
//           ),
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Summary",
//                   style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).accentColor),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "ทั้งหมด",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Spacer(),
//                     Text(
//                       "฿60",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }

//   Scaffold showLocationDetail() {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 45,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "รายละเอียดการส่ง",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Theme.of(context).accentColor,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   isShowLocation = !isShowLocation;
//                 });
//               },
//               icon: Icon(
//                 Icons.close,
//                 color: Colors.white,
//               ))
//         ],
//       ),
//       body: SafeArea(
//           child: ListView(
//         // padding: EdgeInsets.symmetric(horizontal: 16),
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               border: Border(
//                   bottom: BorderSide(
//                       width: 1,
//                       color: Theme.of(context).accentColor,
//                       style: BorderStyle.solid)),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         "1",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green.shade500),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 8,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "รับจาก",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.green.shade500),
//                           ),
//                           Text(
//                             "ร้านผลไม้",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(
//                   bottom: BorderSide(
//                       width: 1,
//                       color: Theme.of(context).accentColor,
//                       style: BorderStyle.solid)),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Text(
//                         "2",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red.shade500),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 8,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "ส่ง",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red.shade500),
//                           ),
//                           Text(
//                             "Maha Village",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             "ลูกค้า : สมปอน",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/screens/order/rider_result_screen.dart';
import 'package:market_delivery/screens/rider/rider_inorder_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:market_delivery/utils/calculate_distance.dart';
import 'package:market_delivery/widgets/custom_switch_widget.dart';

import 'package:provider/provider.dart';

import '../widgets/drawer/rider_drawer.dart';
import './stream_api_screen.dart';
import 'package:http/http.dart' as http;

import 'package:market_delivery/widgets/order/rider_order_modal.dart';

import '../model/rider.dart';

class RiderScreen extends StatelessWidget {
  static const routeName = "/rider-screen";

  Stream<http.Response> getRandomNumberFact({required String riderId}) async* {
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return http
          .get(Uri.parse(Api.orders + "?rider_id=$riderId&order_status=0"));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    final riderProvider = Provider.of<Riders>(context, listen: false);
    final orders = Provider.of<Orders>(context, listen: false);
    riderProvider.findById();
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(child: RiderDrawer()),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("หน้าหลัก"),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.notifications_none),
          // ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => StreamApiScreen()));
          //   },
          //   icon: Icon(Icons.notifications_none),
          // ),
          Consumer<Riders>(
            builder: (context, riderData, child) => Row(
              children: [
                CustomSwitchWidget(
                  onToggle: (value) async {
                    if (value == true) {
                      riderData.riderModel!.riderStatus = 'active';
                      final snackBar = SnackBar(
                        backgroundColor: Colors.green,
                        content: const Text('ออนไลน์'),
                        // action: SnackBarAction(
                        //   label: 'ตกลง',
                        //   textColor: Colors.white,
                        //   onPressed: () {
                        //     // Some code to undo the change.
                        //   },
                        // ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      riderData.riderModel!.riderStatus = 'offline';
                      final snackBar = SnackBar(
                        content: const Text('ออฟไลน์'),
                        // action: SnackBarAction(
                        //   label: 'ตกลง',
                        //   onPressed: () {
                        //     // Some code to undo the change.
                        //   },
                        // ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    print(value);
                    await riderData.updateStatus();
                    riderData.notifyListeners();
                  },
                  isActive: riderData.riderModel!.riderStatus == 'active'
                      ? true
                      : false,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.online_prediction,
                      color: riderData.riderModel!.riderStatus == 'active'
                          ? Colors.green
                          : Colors.grey,
                    )),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<Riders>(builder: (context, riderData, child) {
        if (riderData.riderModel != null) {
          return Container(
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Container(
                  child: StreamBuilder<http.Response>(
                    stream: getRandomNumberFact(
                        riderId: riderProvider.riderModel!.riderId),
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
                                  backgroundColor:
                                      Theme.of(context).accentColor,
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: showMapOrder(
                                          latLng1: LatLng(
                                              riderProvider.riderModel!.lat,
                                              riderProvider.riderModel!.lng),
                                          latLng2: LatLng(
                                              orders.order!.addressId.lat,
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Text(
                                                  "ค่าโดยสาร",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                          BorderRadius.circular(
                                                              7),
                                                      border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                          style: BorderStyle
                                                              .solid)),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          7),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          7)),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text("ระยะทางไปร้าน " +
                                                                  CalculateDistance.calDistanceLatLng(
                                                                          lat1: orders
                                                                              .order!
                                                                              .riderId
                                                                              .lat,
                                                                          lng1: orders
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
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            7,
                                                                        vertical:
                                                                            3),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blue
                                                                        .shade100,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7)),
                                                                child: orders
                                                                            .order!
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  orders
                                                                      .order!
                                                                      .storeId
                                                                      .storeName,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                    orders
                                                                        .order!
                                                                        .storeId
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade200,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          7),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          7)),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  orders
                                                                      .order!
                                                                      .customerId
                                                                      .customerName,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  orders
                                                                      .order!
                                                                      .addressId
                                                                      .address,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54),
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
                                            onPressed: () async {
                                              debugPrint(orders.order!.orderId
                                                  .toString());
                                              await orders.updateOrderStatus(
                                                  orderId:
                                                      orders.order!.orderId,
                                                  orderStatus: '1');
                                              Navigator.of(context).pushNamed(
                                                  RiderInorderScreen.routeName,
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
                            // case '1':
                            //   return Center(child: Text("STATUS 1"));
                            default:
                              return Center(child: showMap());
                          }
                        } else {
                          return Center(child: showMap());
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                // showMap(),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Consumer<Riders>(
          builder: (context, riderData, child) => Row(
            children: [
              riderData.riderModel!.riderStatus == 'active'
                  ? Text(
                      'ออนไลน์',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'ออฟไลน์',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
            ],
          ),
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

  Container showMap() {
    LatLng latLng = LatLng(16.20144295022659, 103.28276975227374);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {},
      ),
    );
  }

  Container showMapOrderOld() {
    LatLng latLng = LatLng(16.20144295022659, 103.28276975227374);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {},
      ),
    );
  }
}
