import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:market_delivery/widgets/text_field_widget.dart';
import '../../model/customer.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  static const routeName = "/add-address-screen";

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  List<Marker> myMarker = [];
  int isSelect = 0;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (context).read<Customers>().findLatLng();
  }

  @override
  Widget build(BuildContext context) {
    final watchCustomer = (context).watch<Customers>();
    final readCustomer = (context).read<Customers>();

    LatLng latLng = LatLng(
        watchCustomer.lat != null ? watchCustomer.lat! : 13.736717,
        watchCustomer.lng != null ? watchCustomer.lng : 100.523186);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: watchCustomer.lat != null ? 16.0 : 50,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 45,
        title: Text("ตำแหน่งที่อยู่"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                readCustomer.notifyListeners();
              },
              child: Text(
                "บันทึก",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Container(
        child: Consumer<Customers>(
          builder: (context, customerConsumer, child) => Column(
            children: [
              Expanded(
                flex: 5,
                child: (watchCustomer.lat != null && watchCustomer.lng != null)
                    ? GoogleMap(
                        onTap: _handleTap,
                        initialCameraPosition: cameraPosition,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        onMapCreated: _onMapCreated,
                        markers: Set.from(myMarker),
                        zoomGesturesEnabled: true,
                        mapToolbarEnabled: true,
                        tiltGesturesEnabled: true,
                        gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                          new Factory<OneSequenceGestureRecognizer>(
                            () => new EagerGestureRecognizer(),
                          ),
                        ].toSet())
                    // ? GoogleMap(
                    //     initialCameraPosition: cameraPosition,
                    //     onMapCreated: _onMapCreated,
                    //     zoomControlsEnabled: false,
                    //     zoomGesturesEnabled: true,
                    //     scrollGesturesEnabled: true,
                    //     compassEnabled: true,
                    //     rotateGesturesEnabled: true,
                    //     mapToolbarEnabled: true,
                    //     tiltGesturesEnabled: true,
                    //     gestureRecognizers:
                    //         <Factory<OneSequenceGestureRecognizer>>[
                    //       new Factory<OneSequenceGestureRecognizer>(
                    //         () => new EagerGestureRecognizer(),
                    //       ),
                    //     ].toSet())
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(height: 50),
    );
  }

  _handleTap(LatLng tappedPoint) {
    final customer = Provider.of<Customers>(context, listen: false);
    print(tappedPoint);
    customer.setLatLng(tappedPoint); //set Lat Lng to Provider Customers
    myMarker = [];
    myMarker.add((Marker(
      markerId: MarkerId(tappedPoint.toString()),
      position: tappedPoint,
    )));
    customer.notifyListeners();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
}
