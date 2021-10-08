import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../model/cart.dart';
import '../model/customer.dart';
import '../model/store.dart';
import '../model/order.dart';
import '../model/rider.dart';
import '../model/address_model.dart';

import '../widgets/cart_list.dart';

import '../utils/calculate_distance.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    final customerProvider = Provider.of<Customers>(context, listen: false);
    final storeProvider = Provider.of<Stores>(context, listen: false);
    final orderProvider = Provider.of<Orders>(context, listen: false);
    final riderProvider = Provider.of<Riders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("ตะกร้าสินค้า"),
      ),
      body: customerProvider.customerModel == null
          ? Center(
              child: Text("กรุณาเข้าสู่ระบบ"),
            )
          : (cartItem.cart.length < 1)
              ? Center(
                  child: Text(
                    "No Selected Foods",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "ร้าน ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: storeProvider.allStores
                                      .firstWhere((element) =>
                                          element.storeId ==
                                          cartItem.cart.values
                                              .toList()[0]
                                              .product
                                              .storeId)
                                      .storeName,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        color: Colors.white,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: cartItem.cart.length,
                            itemBuilder: (context, i) {
                              return CartList(
                                id: cartItem.cart.keys.toList()[i],
                                cartId: cartItem.cart.values
                                    .toList()[i]
                                    .product
                                    .productId,
                                cartTitle: cartItem.cart.values
                                    .toList()[i]
                                    .product
                                    .productName,
                                cartPrice: double.parse(cartItem.cart.values
                                    .toList()[i]
                                    .product
                                    .price),
                                cartQuantity:
                                    cartItem.cart.values.toList()[i].quantity,
                              );
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, bottom: 16, top: 10),
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Summary",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "สินค้า",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "฿${cartItem.totalFood.toStringAsFixed(0)}",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ทั้งหมด : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                Text(
                                  "฿${cartItem.totalFood.toStringAsFixed(0)} บาท",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Consumer<Customers>(
                        builder: (context, customerData, child) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ส่งที่",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                        child: Text(
                                      customerData.listAddressModel
                                          .firstWhere((element) =>
                                              element.addrStatus == "1")
                                          .address,
                                      style: TextStyle(color: Colors.black54),
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width * 0.5,
                                child: showMap(context: context),
                              ),
                              Divider(),
                              Container(
                                child: Row(
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: [
                                          TextSpan(
                                              text: "ระยะห่าง " +
                                                  CalculateDistance
                                                      .calDistanceLatLng(
                                                    lat1: customerData
                                                        .listAddressModel
                                                        .firstWhere((element) =>
                                                            element
                                                                .addrStatus ==
                                                            "1")
                                                        .lat,
                                                    lng1: customerData
                                                        .listAddressModel
                                                        .firstWhere((element) =>
                                                            element
                                                                .addrStatus ==
                                                            "1")
                                                        .lng,
                                                    lat2: storeProvider
                                                        .allStores
                                                        .firstWhere((element) =>
                                                            element.storeId ==
                                                            cartItem.cart.values
                                                                .toList()[0]
                                                                .product
                                                                .storeId)
                                                        .lat,
                                                    lng2: storeProvider
                                                        .allStores
                                                        .firstWhere((element) =>
                                                            element.storeId ==
                                                            cartItem.cart.values
                                                                .toList()[0]
                                                                .product
                                                                .storeId)
                                                        .lng,
                                                  ).toString() +
                                                  " Km",
                                              style: TextStyle(
                                                  color: Colors.black54))
                                        ])),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        showModalAddress(context: context);
                                      },
                                      child: RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black),
                                              children: [
                                            TextSpan(
                                                text: 'เลือกที่อยู่',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ])),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () async {
                          showModalCashMethod(context: context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "วิธีการชำระเงิน",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ชำระเงิน",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "ชำระเงินปลายทาง",
                                            style: TextStyle(
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 17,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: TextButton(
                                onPressed: () async {
                                  List<Map<String, dynamic>> _listMapCal = [];
                                  Map _mapCal = {};
                                  //----------------------------------NOT FINISH-----------------------------
                                  await riderProvider.getRiders();
                                  riderProvider.riders;
                                  for (var item in riderProvider.riders) {
                                    double distance =
                                        CalculateDistance.calDistanceLatLng(
                                            lat1: storeProvider.allStores
                                                .firstWhere((element) =>
                                                    element.storeId ==
                                                    cartItem.cart.values
                                                        .toList()[0]
                                                        .product
                                                        .storeId)
                                                .lat,
                                            lng1: storeProvider.allStores
                                                .firstWhere((element) =>
                                                    element.storeId ==
                                                    cartItem.cart.values
                                                        .toList()[0]
                                                        .product
                                                        .storeId)
                                                .lng,
                                            lat2: item.lat,
                                            lng2: item.lng);

                                    _listMapCal.add({
                                      'rider_id': item.riderId,
                                      'distance': distance,
                                    });

                                    _mapCal[item.riderId] = distance;
                                  }
                                  debugPrint(_listMapCal.toList().toString());
                                  debugPrint(_mapCal.toString());

                                  var mapEntries = _mapCal.entries.toList()
                                    ..sort(
                                        (a, b) => a.value.compareTo(b.value));

                                  _mapCal
                                    ..clear()
                                    ..addEntries(mapEntries);

                                  debugPrint(_mapCal.toString());
                                  debugPrint(
                                      _mapCal.keys.toList().first.toString());
                                  debugPrint(
                                      _mapCal.values.toList().first.toString());
                                  debugPrint(customerProvider
                                      .customerModel!.customerId
                                      .toString());

                                  var now = new DateTime.now();
                                  var formatter = new DateFormat('yyyy-MM-dd');
                                  String formattedDate = formatter.format(now);

                                  orderProvider.addOrder(
                                      storeId: cartItem.cart.values
                                          .toList()[0]
                                          .product
                                          .storeId,
                                      riderId: _mapCal.keys
                                          .toList()
                                          .first
                                          .toString(),
                                      customerId: customerProvider
                                          .customerModel!.customerId
                                          .toString(),
                                      orderDate: formattedDate,
                                      cashMethod: "1",
                                      total: cartItem.cart.length.toString());
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "สั่งออเดอร์",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
    );
  }

  Container showMap({required BuildContext context}) {
    final customerProvider = Provider.of<Customers>(context, listen: false);

    Completer<GoogleMapController> _controller = Completer();
    List<Marker> _marker = [];
    return Container(
      child: Consumer<Customers>(builder: (ctx, customerData, child) {
        AddressModel addressModel = customerProvider.listAddressModel
            .firstWhere((element) => element.addrStatus == "1");
        return Container(
          child: GoogleMap(
            onTap: (LatLng latLng) async {},

            initialCameraPosition: CameraPosition(
              target: LatLng(
                  addressModel.lat != null ? addressModel.lat : 16.0132,
                  addressModel.lng != null ? addressModel.lng : 103.1615),
              zoom: 14.0,
            ),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            // myLocationEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {},
            // markers: Set.from(_marker),
            markers: {
              if (addressModel.lat != null)
                Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(addressModel.lat, addressModel.lng),
                  // infoWindow: InfoWindow(
                  //     title: "สนามบินสุวรรณภูมิ",
                  //     snippet: "สนามบินนานาชาติของประเทศไทย"),
                ),
            },
          ),
        );
      }),
    );
  }

  showModalCashMethod({required BuildContext context}) {
    final cartProvider = Provider.of<Cart>(context, listen: false);
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade200,
              elevation: 1,
              toolbarHeight: 45,
              centerTitle: true,
              title: Text("วิธีการชำระเงิน"),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close)),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "การชำระเงิน",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cartProvider.paymentMethod.length,
                            itemBuilder: (context, i) => InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                debugPrint('Method Selected');
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartProvider.paymentMethod[i]
                                              ['cash_method'],
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(cartProvider.paymentMethod[i]
                                                ['shipping_cost'] +
                                            " บาท"),
                                      ],
                                    )),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 17,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  showModalAddress({required BuildContext context}) {
    final customerProvider = Provider.of<Customers>(context, listen: false);
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade200,
              elevation: 1,
              toolbarHeight: 45,
              centerTitle: true,
              title: Text("เลือกที่อยู่"),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close)),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "ที่อยู่ของฉัน",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          ListView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: customerProvider.listAddressModel.length,
                            itemBuilder: (context, i) => InkWell(
                              onTap: () async {
                                await customerProvider.updateAddressStatus(
                                    addressId: customerProvider
                                        .listAddressModel[i].addressId
                                        .toString(),
                                    addrStatus: "1");
                                // Navigator.of(context).pop();
                                await customerProvider.findAddress();
                                Navigator.of(context).pop();
                                debugPrint('Method Selected');
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 7),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      size: 17,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          customerProvider
                                              .listAddressModel[i].address,
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    )),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 17,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
