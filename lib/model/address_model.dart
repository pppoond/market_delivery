// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

class AddressModel {
  AddressModel({
    required this.addressId,
    required this.customerId,
    this.address = "",
    this.lat = 0,
    this.lng = 0,
    this.addrStatus = "",
    required this.timeReg,
  });

  int addressId;
  int customerId;
  String address;
  double lat;
  double lng;
  String addrStatus;
  DateTime timeReg;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressId: json["address_id"],
        customerId: json["customer_id"],
        address: json["address"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        addrStatus: json["addr_status"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "customer_id": customerId,
        "address": address,
        "lat": lat,
        "lng": lng,
        "addr_status": addrStatus,
        "time_reg": timeReg.toIso8601String(),
      };
}
