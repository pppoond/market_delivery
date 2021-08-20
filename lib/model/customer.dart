// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    required this.result,
  });

  List<Result> result;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.customerId,
    required this.username,
    required this.password,
    required this.customerName,
    required this.customerPhone,
    required this.sex,
    required this.timeReg,
  });

  final int customerId;
  final String username;
  final String password;
  final String customerName;
  final String customerPhone;
  final String sex;
  final DateTime timeReg;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        customerId: json["customer_id"],
        username: json["username"],
        password: json["password"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        sex: json["sex"],
        timeReg: DateTime.parse(json["time_reg"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "username": username,
        "password": password,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "sex": sex,
        "time_reg": timeReg.toIso8601String(),
      };
}
