import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class RiderFillModal {
  static Future<dynamic> showModal({
    required BuildContext context,
  }) {
    return showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.55),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            TextEditingController textFieldController = TextEditingController();
            Widget userInputField(
                {required String hintText,
                var icon,
                var controller,
                required bool obscureText}) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  obscureText: obscureText,
                  controller: controller,
                  decoration: InputDecoration(
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
                        borderSide: BorderSide(
                            width: 1, color: Theme.of(context).accentColor)),
                  ),
                  // focusedBorder: UnderlineInputBorder(
                  //     borderSide: BorderSide(
                  //         width: 1, color: Theme.of(context).accentColor))),
                ),
              );
            }

            return Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0),

                // border: Border(
                //   top: BorderSide(

                //     width: 0,
                //     color: Colors.black.withOpacity(0),
                //   ),
                // ),
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Consumer<Riders>(
                  builder: (context, riderData, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "เติมเครดิต",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "กระเป๋าเงิน ${riderData.riderModel!.wallet}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "กระเป๋าเครดิต ${riderData.riderModel!.credit}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      userInputField(
                          hintText: 'จำนวนเงิน',
                          obscureText: false,
                          controller: riderData.amountMoneyController),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          if (riderData.amountMoneyController.text == '') {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                title: 'กรุณาใส่จำนวนเงิน',
                                confirmBtnText: 'ตกลง');
                          } else if (double.parse(
                                  riderData.amountMoneyController.text) >
                              double.parse(riderData.riderModel!.wallet)) {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                title: 'จำนวนเงินไม่เพียงพอ',
                                confirmBtnText: 'ตกลง');
                          } else {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.confirm,
                                title: 'ยืนยันเพื่อเติมเข้าเครดิต',
                                cancelBtnText: 'ยกเลิก',
                                confirmBtnText: 'ยืนยัน',
                                onConfirmBtnTap: () async {
                                  String result =
                                      await riderData.paymentCredit();

                                  if (result == 'success') {
                                    await CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        title: 'เติมเข้าเครดิตสำเร็จ',
                                        confirmBtnText: 'ตกลง');
                                    Navigator.of(context).pop();
                                  } else {
                                    await CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        title:
                                            'มีข้อผิดพลาด กรุณาลองอีกครั้งภายหลัง',
                                        confirmBtnText: 'ตกลง');
                                    Navigator.of(context).pop();
                                  }
                                });
                          }
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
                          "เติมเข้าเครดิต",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
