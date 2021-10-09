import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../model/store.dart';

class StoreLocationScreen extends StatelessWidget {
  static const routeName = "/store-location-screen";
  List<Marker> myMarker = [];

  int isSelect = 0;

  Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;

  Widget userInputField(
      {required BuildContext context,
      required String hintText,
      required String labelText,
      var icon,
      TextEditingController? controller,
      required bool obscureText}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          prefixIcon: (icon == null) ? null : icon,
          // icon: (icon == null) ? null : icon,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).accentColor)),
        ),
        // focusedBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //         width: 1, color: Theme.of(context).accentColor))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<Stores>(context, listen: false);
    LatLng latLng = LatLng(
        storeProvider.storeModel.lat == 0
            ? 16.186952554767316
            : storeProvider.storeModel.lat,
        storeProvider.storeModel.lng == 0
            ? 103.30240284137928
            : storeProvider.storeModel.lat);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: storeProvider.storeModel.lat != null ? 14.0 : 14,
    );
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
                  color: Colors.black, //change your color here
                ),
                automaticallyImplyLeading: true,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                toolbarHeight: 45,
                elevation: 1,
                centerTitle: true,
                title: Text(
                  'ตำแหน่งร้าน',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: Consumer<Stores>(
                builder: (context, storeData, child) => Center(
                  child: Column(
                    children: [
                      Expanded(
                          child: GoogleMap(
                              onTap: (latLng) {
                                _handleTap(context, latLng);
                              },
                              // padding: EdgeInsets.only(top: 155),
                              initialCameraPosition: cameraPosition,
                              mapType: MapType.normal,
                              // myLocationButtonEnabled: true,
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
                              ].toSet()))
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: _goToMe,
                label: Text('My Location'),
                icon: Icon(Icons.location_on),
              ),
              bottomNavigationBar: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ที่อยู่',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: RichText(
                                    text: TextSpan(children: [
                              TextSpan(text: 'asdalskdjalskdjalsjd')
                            ])))
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (storeProvider.latTextController.text != '') {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.confirm,
                                  text: 'ยืนยัน เพื่อบันทึกการเปลี่ยนแปลง',
                                  title: 'ยืนยัน',
                                  cancelBtnText: 'ยกเลิก',
                                  confirmBtnText: 'ยืนยัน',
                                  onConfirmBtnTap: () async {
                                    var result =
                                        await storeProvider.updateLatLng();
                                    if (result == 'success') {
                                      Navigator.of(context).pop();
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        confirmBtnText: 'ตกลง',
                                      );
                                    } else {
                                      Navigator.of(context).pop();
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        confirmBtnText: 'ตกลง',
                                      );
                                    }
                                  });
                            } else {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: 'กรุณากรอกข้อมูลให้ครบ',
                                  confirmBtnText: 'ตกลง');
                            }
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
                            "บันทึก",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
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

  _handleTap(BuildContext context, LatLng tappedPoint) {
    final storeProvider = Provider.of<Stores>(context, listen: false);
    print(tappedPoint);
    //set Lat Lng to Provider Stores
    myMarker = [];
    myMarker.add((Marker(
      markerId: MarkerId(tappedPoint.toString()),
      position: tappedPoint,
    )));
    storeProvider.setLatLng(tappedPoint);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }

  Future _goToMe() async {
    final GoogleMapController controller = await _controller.future;
    currentLocation = await getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      zoom: 16,
    )));
  }
}
