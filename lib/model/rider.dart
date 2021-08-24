import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

class Riders with ChangeNotifier {
  
  Future<bool> loginRider(
      {required String username, required String password}) async {
    bool login;
    var response = await http.post(Uri.parse(Api.loginRider), body: {
      'username': username,
      'password': password,
    });
    print(response.body);
    if (response.body != null) {
      login = true;
    } else {
      login = false;
    }
    
    return login;
  }
}
