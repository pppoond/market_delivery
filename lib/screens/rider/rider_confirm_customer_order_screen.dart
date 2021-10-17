import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/order.dart';
import 'package:market_delivery/model/order_detail.dart';
import 'package:market_delivery/screens/rider_screen.dart';
import 'package:provider/provider.dart';

import '../../model/store.dart';

class RiderConfirmCustomerOrderScreen extends StatelessWidget {
  static const routeName = "/rider-confirm-customer-order-screen";
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
    String orderId = ModalRoute.of(context)!.settings.arguments as String;
    final orderDetailProvider =
        Provider.of<OrderDetails>(context, listen: false);
    final orders = Provider.of<Orders>(context, listen: false);
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
                  color: Colors.white, //change your color here
                ),
                automaticallyImplyLeading: true,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                toolbarHeight: 45,
                elevation: 1,
                centerTitle: true,
                title: Text(
                  'รายละเอียดคำสั่งซื้อ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                child: Consumer<OrderDetails>(
                  builder: (context, detailData, child) => Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Text(
                                          'คำสั่งซื้อที่ ${detailData.orderDetailList[0].orderId.orderId}',
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              detailData.orderDetailList[0]
                                                          .orderId.cashMethod ==
                                                      '1'
                                                  ? 'ชำระเงินสด'
                                                  : 'พร้อมเพย์',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              detailData.orderDetailList[0]
                                                  .orderId.storeId.storeName,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.motorcycle_sharp,
                                              color: Colors.green,
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              detailData.orderDetailList[0]
                                                  .orderId.riderId.riderName,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: detailData
                                                .orderDetailList.length,
                                            itemBuilder: (context, i) {
                                              return Row(
                                                children: [
                                                  SizedBox(
                                                    width: 16,
                                                  ),
                                                  Text(detailData
                                                      .orderDetailList[i]
                                                      .productId
                                                      .productName),
                                                  Spacer(),
                                                  RichText(
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          children: [
                                                        TextSpan(
                                                            text: '฿' +
                                                                detailData
                                                                    .orderDetailList[
                                                                        i]
                                                                    .productId
                                                                    .price +
                                                                ' x ' +
                                                                detailData
                                                                    .orderDetailList[
                                                                        i]
                                                                    .quantity +
                                                                ' = ${double.parse(detailData.orderDetailList[i].quantity) * double.parse(detailData.orderDetailList[i].productId.price)}')
                                                      ])),
                                                  SizedBox(
                                                    width: 16,
                                                  ),
                                                ],
                                              );
                                            }),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Sumary',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              detailData.totalMoney.toString() +
                                                  '฿',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'ค่าส่ง',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              '15.0฿',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Divider(),
                                        Row(
                                          children: [
                                            Text(
                                              'รวม',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Text(
                                              detailData.totalPayment
                                                      .toString() +
                                                  '฿',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: () async {
                      await CoolAlert.show(
                          context: context,
                          type: CoolAlertType.confirm,
                          title: 'ยืนยัน',
                          text: 'ลูกค้ารับสินค้าและชำระเงินแล้วหรือไม่?',
                          confirmBtnText: 'ยืนยัน',
                          cancelBtnText: 'ยกเลิก',
                          onConfirmBtnTap: () async {
                            await orders.updateOrderStatus(
                                orderId: orderId, orderStatus: '4');
                            Navigator.of(context).pop();
                            await CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                confirmBtnText: 'ตกลง');

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RiderScreen.routeName, (route) => false);
                            // await orders.updateOrderStatus(
                            //     orderId: orderId,
                            //     orderStatus: '2');
                          });
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
                      "ส่งสินค้า",
                      style: TextStyle(
                        fontSize: 18,
                      ),
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
}
