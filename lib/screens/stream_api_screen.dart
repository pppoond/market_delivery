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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';

import '../model/order.dart';

class StreamApiScreen extends StatelessWidget {
  Stream<http.Response> getRandomNumberFact() async* {
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return http.get(Uri.parse(Api.orders));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder<http.Response>(
          stream: getRandomNumberFact(),
          builder: (context, snapshot) {
            if (snapshot.data!.body != null) {
              // dynamic jsonString = jsonEncode(snapshot.data!.body);
              dynamic jsonData = jsonDecode(snapshot.data!.body);
              print(jsonData['result'].toString());
              var result = jsonData['result'];
              if (result[0]['status'] == "1") {
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
                        onPressed: () {
                          // setState(() {
                          //   noOrder = !noOrder;
                          // });
                        },
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
                        child: showMapOrder(),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "THB",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                                    borderRadius: BorderRadius.circular(7)),
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
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                          width: 1,
                                          color: Theme.of(context).accentColor,
                                          style: BorderStyle.solid)),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7),
                                              topRight: Radius.circular(7)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("ระยะทาง 0.5 KM"),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7, vertical: 3),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Text(
                                                  "เงินสด",
                                                  style: TextStyle(),
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
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "ร้านผลไม้",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "ตลาดสดเทสบาล อ.เมือง จ.มหาสารคาม"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(7),
                                              bottomRight: Radius.circular(7)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Maha Village",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "บ้านเลขที่ 71/3\nถนนนครสวรร ซ.17 อ.เมือง จ.มหาสารคาม"),
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
                              onPressed: () {
                                orders.getOrder();
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Theme.of(context).accentColor,
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
              } else {
                return Center(
                    child: ListView(
                  children: [
                    ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: jsonData['result'].length > 0
                          ? jsonData['result'].length
                          : 0,
                      itemBuilder: (context, i) {
                        return Card(
                          child: Text(jsonData['result'][i]['store_id']),
                        );
                      },
                    ),
                    Text(
                      snapshot.data!.body,
                      style: TextStyle(color: Colors.green, fontSize: 17),
                    ),
                  ],
                ));
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Container showMapOrder() {
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
