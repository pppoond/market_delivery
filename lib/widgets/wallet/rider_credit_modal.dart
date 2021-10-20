import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class RiderCreditModal {
  static Future<dynamic> showModal({
    required BuildContext ctx,
    required String orderId,
  }) {
    Widget userInputField(
        {required BuildContext ctx,
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
                    BorderSide(width: 1, color: Theme.of(ctx).accentColor)),
          ),
          // focusedBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(
          //         width: 1, color: Theme.of(context).accentColor))),
        ),
      );
    }

    return showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.55),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: ctx,
        builder: (ctx) {
          return StatefulBuilder(builder: (ctx, setState) {
            TextEditingController textFieldController = TextEditingController();
            return Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(ctx).size.height * 0.8,
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
                padding:
                    EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Consumer<Riders>(
                  builder: (ctx, riderData, child) => Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ถอนเครดิตเข้ากระเป๋าเงิน",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                elevation: 0,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "เครดิต ${riderData.riderModel!.credit}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(ctx).accentColor),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              userInputField(
                                  hintText: "จำนวนเครดิต",
                                  controller: riderData.creditController,
                                  ctx: ctx,
                                  labelText: 'จำนวนเครดิต',
                                  obscureText: false),
                              TextButton(
                                onPressed: () {
                                  if (riderData.creditController.text != '') {
                                    if (int.parse(
                                            riderData.creditController.text) <=
                                        int.parse(
                                            riderData.riderModel!.credit)) {
                                      CoolAlert.show(
                                          context: ctx,
                                          type: CoolAlertType.confirm,
                                          title: 'ยืนยัน',
                                          text: 'ต้องการถอนเครดิตหรือไม่?',
                                          confirmBtnText: 'ยืนยัน',
                                          cancelBtnText: 'ยกเลิก',
                                          onConfirmBtnTap: () async {
                                            String success = await riderData
                                                .updateCreditRider();
                                            if (success == 'success') {
                                              Navigator.of(ctx).pop();
                                              await CoolAlert.show(
                                                context: ctx,
                                                type: CoolAlertType.success,
                                                confirmBtnText: 'ตกลง',
                                              );
                                              Navigator.of(ctx).pop();
                                            } else {
                                              Navigator.of(ctx).pop();
                                              await CoolAlert.show(
                                                context: ctx,
                                                type: CoolAlertType.error,
                                                confirmBtnText: 'ตกลง',
                                              );
                                              Navigator.of(ctx).pop();
                                            }
                                          });
                                    } else {
                                      CoolAlert.show(
                                        context: ctx,
                                        type: CoolAlertType.error,
                                        title: 'ยอดเครดิตไม่เพียงพอ',
                                        confirmBtnText: 'ตกลง',
                                      );
                                    }
                                  } else {
                                    CoolAlert.show(
                                      context: ctx,
                                      type: CoolAlertType.error,
                                      title: 'กรุณากรอกข้อมูลให้ครบ',
                                      confirmBtnText: 'ตกลง',
                                    );
                                  }
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Theme.of(ctx).accentColor,
                                  minimumSize: Size(
                                    double.infinity,
                                    50,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "ถอนเครดิต",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
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
