import 'package:flutter/cupertino.dart';
import 'package:flutter_latlong/flutter_latlong.dart';

class CalculateDistance {
  static double calDistanceLatLng({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    final Distance distance = new Distance();

    num? km =
        distance.as(LengthUnit.Meter, LatLng(lat1, lng1), LatLng(lat2, lng2));
    debugPrint(km.toString());

    double distanceInKiloMeters = km!.toDouble() / 1000;
    double roundDistanceInKM =
        double.parse((distanceInKiloMeters).toStringAsFixed(2));

    return roundDistanceInKM;
  }
}
