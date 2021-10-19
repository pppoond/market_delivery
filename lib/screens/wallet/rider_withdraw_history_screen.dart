import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/model/withdraw_rider.dart';
import 'package:provider/provider.dart';

class RiderWithdrawHistoryScreen extends StatelessWidget {
  static const routeName = "/rider-withdraw-history-screen";

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
                  'ประวัติการทำรายการ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                child: Consumer<WithdrawRiders>(
                  builder: (context, withdrawRiderData, child) => Center(
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
                                            itemCount: withdrawRiderData
                                                .withdrawRiders.length,
                                            itemBuilder: (context, i) {
                                              return InkWell(
                                                onTap: () {
                                                  showModal(
                                                      ctx: context,
                                                      withdrawRider:
                                                          withdrawRiderData
                                                              .withdrawRiders[i]);
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
                                                                      text: withdrawRiderData
                                                                          .withdrawRiders[
                                                                              i]
                                                                          .bankName),
                                                                  TextSpan(
                                                                      text:
                                                                          ' '),
                                                                  TextSpan(
                                                                      text: withdrawRiderData
                                                                          .withdrawRiders[
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
                                                                  withdrawRiderData
                                                                              .withdrawRiders[
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
                                                                      : withdrawRiderData.withdrawRiders[i].payStatus ==
                                                                              '1'
                                                                          ? TextSpan(
                                                                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                                                              text: "โอนสำเร็จ")
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
    required WithdrawRider withdrawRider,
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
                          "รายการถอนเงิน",
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
                          withdrawRider.wdRiderId,
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
                              TextSpan(text: withdrawRider.riderId.riderName),
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
                              TextSpan(text: withdrawRider.bankName),
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
                              TextSpan(text: withdrawRider.noBankAccount),
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
                              TextSpan(text: withdrawRider.total),
                            ])),
                        SizedBox(
                          height: 16,
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                withdrawRider.payStatus == '0'
                                    ? TextSpan(
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        text: "กำลังดำเนินการ")
                                    : withdrawRider.payStatus == '1'
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
                            withdrawRider.payStatus == '2' ||
                                    withdrawRider.payStatus == '1'
                                ? SizedBox()
                                : Expanded(
                                    child: TextButton(
                                      onPressed: () async {
                                        CoolAlert.show(
                                            context: ctx,
                                            type: CoolAlertType.confirm,
                                            confirmBtnText: 'ยืนยัน',
                                            cancelBtnText: 'ยกเลิก',
                                            title: 'ยืนยัน',
                                            text: 'ยืนยันเพื่อยกเลิกรายการ',
                                            onConfirmBtnTap: () async {
                                              String success =
                                                  await withdrawRiderProvider
                                                      .updateWithdrawStatus(
                                                          wdRiderId:
                                                              withdrawRider
                                                                  .wdRiderId,
                                                          payStatus: '2');

                                              await withdrawRiderProvider
                                                  .findWithdrawByRiderId(
                                                      riderId: riderData
                                                          .riderModel!.riderId);
                                              withdrawRiderProvider
                                                  .notifyListeners();

                                              if (success == 'success') {
                                                var wallet = double.parse(
                                                        riderData.riderModel!
                                                            .wallet) +
                                                    double.parse(
                                                        withdrawRider.total);
                                                await riderData
                                                    .updateWalletRider(
                                                        wallet:
                                                            wallet.toString());
                                                Navigator.of(ctx).pop();
                                                await CoolAlert.show(
                                                    context: ctx,
                                                    type: CoolAlertType.success,
                                                    confirmBtnText: 'ตกลง');

                                                Navigator.of(ctx).pop();
                                              } else {
                                                Navigator.of(ctx).pop();
                                                await CoolAlert.show(
                                                    context: ctx,
                                                    type: CoolAlertType.error,
                                                    confirmBtnText: 'ตกลง');

                                                Navigator.of(ctx).pop();
                                              }
                                            });
                                        // print(dropdownValue);
                                      },
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        "ยกเลิกรายการ",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: 7,
                            ),
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
