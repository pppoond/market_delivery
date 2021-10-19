import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/model/withdraw_rider.dart';
import 'package:market_delivery/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class RiderMoneyModal {
  static Future<dynamic> showModal({
    required BuildContext ctx,
    required String orderId,
  }) {
    final riderProvider = Provider.of<Riders>(ctx, listen: false);
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
            final withdrawRider =
                Provider.of<WithdrawRiders>(ctx, listen: false);
            return Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(ctx).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0),
              ),
              child: Consumer<Riders>(
                builder: (context, riderData, child) => Container(
                  padding: EdgeInsets.only(
                      top: 12,
                      left: 12,
                      right: 12,
                      bottom: MediaQuery.of(ctx).viewInsets.bottom),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ถอนเงินเข้าบัญชี",
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
                                    "เงิน ${riderData.riderModel!.wallet}",
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
                            labelText: 'จำนวนเงิน',
                            hintText: 'จำนวนเงิน',
                            obscureText: false,
                            controller: withdrawRider.totalTextController,
                            ctx: ctx),
                        userInputField(
                            labelText: 'ชื่อธนาคาร',
                            hintText: 'ชื่อธนาคาร',
                            obscureText: false,
                            controller: withdrawRider.bankNameTextController,
                            ctx: ctx),
                        userInputField(
                            labelText: 'เลขบัญชีธนาคาร',
                            hintText: 'เลขบัญชีธนาคาร',
                            obscureText: false,
                            controller:
                                withdrawRider.noBankAccountTextController,
                            ctx: ctx),
                        TextButton(
                          onPressed: () async {
                            if (double.parse(
                                    withdrawRider.totalTextController.text) <=
                                double.parse(riderData.riderModel!.wallet)) {
                              CoolAlert.show(
                                  context: ctx,
                                  type: CoolAlertType.confirm,
                                  confirmBtnText: 'ยืนยัน',
                                  cancelBtnText: 'ยกเลิก',
                                  title: 'ยืนยัน',
                                  text:
                                      'ตรวจสอบจำนวนเงินและเลขบัญชีเนียบร้อยแล้วหรือไม่',
                                  onConfirmBtnTap: () async {
                                    String success =
                                        await withdrawRider.addWithdraw(
                                            riderId:
                                                riderData.riderModel!.riderId);

                                    if (success == 'success') {
                                      var wallet = double.parse(riderProvider
                                              .riderModel!.wallet) -
                                          double.parse(withdrawRider
                                              .totalTextController.text);
                                      await riderProvider.updateWalletRider(
                                          wallet: wallet.toString());
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
                            } else {
                              await CoolAlert.show(
                                  context: ctx,
                                  title: 'จำนวนเงินไม่เพียงพอ',
                                  type: CoolAlertType.error,
                                  confirmBtnText: 'ตกลง');
                            }

                            // print(dropdownValue);
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
                            "ถอนเข้าบัญชี",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
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
