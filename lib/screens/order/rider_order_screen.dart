import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class RiderOrderScreen extends StatelessWidget {
  static const routeName = "/rider-order-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("รายการที่ทำสำเร็จ"),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "รายการที่ทำสำเร็จ",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListView.builder(
              itemCount: 3,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Text("17.15 PM"),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Text(
                              "ร้านผลไม้",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              "฿ 19",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
