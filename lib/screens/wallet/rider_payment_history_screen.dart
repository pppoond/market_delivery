import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/payment_rider.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/model/withdraw_rider.dart';
import 'package:provider/provider.dart';

class RiderPaymentHistoryScreen extends StatelessWidget {
  static const routeName = "/rider-payment-history-screen";

  @override
  Widget build(BuildContext context) {
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
                  'ประวัติการฝาก',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                child: Consumer<PaymentRiders>(
                  builder: (context, paymentRiderData, child) => Center(
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
                                        ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: paymentRiderData
                                                .paymentRiderList.length,
                                            itemBuilder: (context, i) {
                                              return InkWell(
                                                onTap: () {
                                                  showModal(
                                                      ctx: context,
                                                      paymentRider: paymentRiderData
                                                          .paymentRiderList[i]);
                                                },
                                                child: Container(
                                                  // padding: EdgeInsets.symmetric(
                                                  //     vertical: 7),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                children: [
                                                                  TextSpan(
                                                                      text: (i +
                                                                              1)
                                                                          .toString()),
                                                                  TextSpan(
                                                                      text:
                                                                          ' '),
                                                                  TextSpan(
                                                                      text: paymentRiderData
                                                                          .paymentRiderList[
                                                                              i]
                                                                          .bankName),
                                                                  TextSpan(
                                                                      text:
                                                                          ' '),
                                                                  TextSpan(
                                                                      text: paymentRiderData
                                                                          .paymentRiderList[
                                                                              i]
                                                                          .noBankAccount),
                                                                ]),
                                                          ),
                                                          Spacer(),
                                                          RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                children: [
                                                                  paymentRiderData
                                                                              .paymentRiderList[
                                                                                  i]
                                                                              .payStatus ==
                                                                          '0'
                                                                      ? TextSpan(
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .red,
                                                                              fontWeight: FontWeight
                                                                                  .bold),
                                                                          text:
                                                                              "กำลังดำเนินการ")
                                                                      : paymentRiderData.paymentRiderList[i].payStatus ==
                                                                              '1'
                                                                          ? TextSpan(
                                                                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                                                              text: "ฝากสำเร็จ")
                                                                          : TextSpan(style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold), text: "ยกเลิก"),
                                                                ]),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider()
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
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
            ),
          ),
        ],
      ),
    );
  }

  showModal({
    required BuildContext ctx,
    required PaymentRider paymentRider,
  }) {
    return showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.55),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: ctx,
        builder: (ctx) {
          return StatefulBuilder(builder: (ctx, setState) {
            final withdrawRiderProvider =
                Provider.of<WithdrawRiders>(ctx, listen: false);
            return Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(ctx).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0),
              ),
              child: Consumer<Riders>(
                builder: (context, riderData, child) => Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "รายการฝากเงิน",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'เลขรายการ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          paymentRider.payRiderId,
                          style: TextStyle(color: Theme.of(ctx).accentColor),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: 'ชื่อ ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: paymentRider.riderId.riderName),
                            ])),
                        SizedBox(
                          height: 16,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: 'ชื่อธนาคาร ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: paymentRider.bankName),
                            ])),
                        SizedBox(
                          height: 16,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: 'เลขบัญชี ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: paymentRider.noBankAccount),
                            ])),
                        SizedBox(
                          height: 16,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: 'จำนวนเงิน ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: paymentRider.total),
                            ])),
                        SizedBox(
                          height: 16,
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                paymentRider.payStatus == '0'
                                    ? TextSpan(
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        text: "กำลังดำเนินการ")
                                    : paymentRider.payStatus == '1'
                                        ? TextSpan(
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                            text: "โอนสำเร็จ")
                                        : TextSpan(
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                            text: "ยกเลิก"),
                              ]),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () async {
                                  Navigator.of(ctx).pop();
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Theme.of(ctx).accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "ปิด",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}
