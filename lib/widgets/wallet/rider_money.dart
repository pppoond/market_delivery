import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/admin.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/model/withdraw_rider.dart';
import 'package:market_delivery/widgets/wallet/rider_money_modal.dart';
import 'package:provider/provider.dart';

class RiderMoney extends StatelessWidget {
  Widget drawerItem({required String title, var leadingIcon, required onTap}) {
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: ListTile(
        leading: leadingIcon == null ? null : leadingIcon,
        title: Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        trailing:
            title == "Log Out" ? null : Icon(Icons.arrow_forward_ios, size: 16),
        dense: true,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<Admins>(context, listen: false);
    return Consumer<Riders>(
      builder: (context, riderData, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.grey.shade200,
              elevation: 0,
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).pushNamed(RiderOrderScreen.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "เงิน",
                            style: TextStyle(fontSize: 22),
                          ),
                          // Spacer(),
                          // Icon(
                          //   Icons.arrow_forward_ios,
                          //   size: 16,
                          // )
                        ],
                      ),
                      Text(
                        "฿ ${riderData.riderModel!.wallet}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Divider(),s
          drawerItem(
              leadingIcon: Icon(
                Icons.money,
              ),
              title: "ถอนเงินเข้าบัญชี",
              onTap: () {
                RiderMoneyModal.showModal(ctx: context, orderId: "1");
              }),
          Divider(),
          drawerItem(
              leadingIcon: Icon(
                Icons.money,
              ),
              title: "เติมเงินเข้าระบบ",
              onTap: () async {
                await adminProvider.getAdmins();
                showModal(ctx: context, orderId: "1");
              }),
          Divider(),
        ],
      ),
    );
  }

  showModal({
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
                          "เติมเงินเข้าระบบ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Consumer<Admins>(
                          builder: (ctx, adminData, child) => Card(
                            elevation: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                      TextSpan(
                                        text: 'ชื่อธนาคาร ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: adminData.adminsList[0].bankName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Theme.of(ctx).accentColor),
                                      ),
                                    ])),
                                SizedBox(
                                  height: 7,
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                      TextSpan(
                                        text: 'ชื่อบัญชี ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            adminData.adminsList[0].accountName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Theme.of(ctx).accentColor),
                                      ),
                                    ])),
                                SizedBox(
                                  height: 7,
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                      TextSpan(
                                        text: 'เลขที่บัญชี ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: adminData
                                            .adminsList[0].noBankAccount,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Theme.of(ctx).accentColor),
                                      ),
                                    ])),
                                SizedBox(
                                  height: 7,
                                ),
                              ],
                            ),
                          ),
                        ),
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
                            "อัพโหลดหลักฐานการโอน",
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
