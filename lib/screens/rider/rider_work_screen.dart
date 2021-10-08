import 'package:flutter/material.dart';

import '../../screens/order/rider_finish_screen.dart';

class RiderWorkScreen extends StatelessWidget {
  static const routeName = "/rider-work-screen";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: Text('งานของฉัน'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("กำลังดำเนินการ"),
              ),
              Tab(
                child: Text("สำเร็จแล้ว"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 7),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt_sharp,
                                color: Theme.of(context).accentColor,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(child: Text("data")),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 17,
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 7),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt_sharp,
                                color: Theme.of(context).accentColor,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(child: Text("data")),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 17,
                              )
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
