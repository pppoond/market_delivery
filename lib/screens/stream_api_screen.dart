import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:market_delivery/utils/api.dart';

class StreamApiScreen extends StatelessWidget {
  Stream<http.Response> getRandomNumberFact() async* {
    yield* Stream.periodic(Duration(seconds: 1), (_) {
      return http.get(Uri.parse(Api.customer));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder<http.Response>(
          stream: getRandomNumberFact(),
          builder: (context, snapshot) {
            dynamic? jsonString = jsonEncode(snapshot.data!.body);
            dynamic? jsonData = jsonDecode(jsonString);
            // var result = jsonData['result'];
            return (snapshot.hasData)
                ? Center(
                    child: ListView(
                    children: [
                      // ListView.builder(
                      //   physics: ScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemCount: result.length,
                      //   itemBuilder: (context, index) {
                      //     return Card(
                      //       child: Text(result[index]['username']),
                      //     );
                      //   },
                      // ),
                      Text(
                        snapshot.data!.body,
                        style: TextStyle(color: Colors.green, fontSize: 17),
                      ),
                    ],
                  ))
                : CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
