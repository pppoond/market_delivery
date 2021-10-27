import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/rider.dart';
import 'package:market_delivery/model/withdraw_store.dart';
import 'package:market_delivery/screens/wallet/store_withdraw_history_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/wallet/rider_money.dart';
import '../../model/store.dart';

class StoreMoneyScreen extends StatelessWidget {
  static const routeName = "/store-money-screen";

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
    final storeProvider = Provider.of<Stores>(context, listen: false);
    final riderProvider = Provider.of<Riders>(context, listen: false);
    final withdrawStoreProvider =
        Provider.of<WithdrawStores>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        elevation: 1,
        title: Text("กระเป๋าเงิน"),
        actions: [
          IconButton(
              onPressed: () async {
                await withdrawStoreProvider.findWithdrawByStoreId(
                    storeId: storeProvider.storeModel.storeId);
                Navigator.of(context)
                    .pushNamed(StoreWithdrawHistoryScreen.routeName);
              },
              icon: Icon(Icons.history)),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<Stores>(
          builder: (context, storeData, child) => Column(
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
                            "฿ ${storeData.storeModel.wallet}",
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
                    showModal(context: context);
                    // RiderMoneyModal.showModal(context: context, orderId: "1");
                  }),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  showModal({
    required BuildContext context,
  }) {
    return showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.55),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          final storeProvider = Provider.of<Stores>(context, listen: false);
          final riderProvider = Provider.of<Riders>(context, listen: false);
          return Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0),
            ),
            child: Consumer<WithdrawStores>(
              builder: (context, withdrawStoreData, child) => Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ถอนเงินเข้าบัญชี",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Consumer<Stores>(
                      builder: (context, storeData, child) => Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "เงิน ${storeData.storeModel.wallet}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor),
                                ),
                                Spacer()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    userInputField(
                        context: context,
                        hintText: 'จำนวนเงิน',
                        labelText: 'จำนวนเงิน',
                        obscureText: false,
                        controller: withdrawStoreData.amountMoneyController),
                    userInputField(
                        context: context,
                        hintText: 'ชื่อธนาคาร',
                        labelText: 'ชื่อธนาคาร',
                        obscureText: false,
                        controller: withdrawStoreData.bankNameController),
                    userInputField(
                        context: context,
                        hintText: 'เลขบัญชี',
                        labelText: 'เลขบัญชี',
                        obscureText: false,
                        controller: withdrawStoreData.noBankAccountController),
                    // DropdownButton<String>(
                    //   value: dropdownValue,
                    //   icon: const Icon(Icons.arrow_downward),
                    //   iconSize: 24,
                    //   elevation: 16,
                    //   style: TextStyle(color: Theme.of(context).accentColor),
                    //   underline: Container(
                    //     height: 2,
                    //     color: Colors.deepPurpleAccent,
                    //   ),
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       dropdownValue = newValue!;
                    //     });
                    //   },
                    //   items: <String>[
                    //     'ไทยพาณิช',
                    //     'กสิกร',
                    //   ].map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       // child: Text(value),
                    //       child: Container(
                    //         width: MediaQuery.of(context).size.width * 0.8,
                    //         padding: EdgeInsets.all(7),
                    //         // color: Colors.red,
                    //         child: Row(
                    //           children: [
                    //             Text(value),
                    //             Spacer(),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        if (withdrawStoreData.amountMoneyController.text !=
                                '' &&
                            withdrawStoreData.bankNameController.text != '' &&
                            withdrawStoreData.noBankAccountController.text !=
                                '') {
                          if (double.parse(withdrawStoreData
                                  .amountMoneyController.text) <=
                              double.parse(storeProvider.storeModel.wallet)) {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.confirm,
                                confirmBtnText: 'ยืนยัน',
                                cancelBtnText: 'ยกเลิก',
                                title: 'ยืนยันการถอนเงิน',
                                onConfirmBtnTap: () async {
                                  String success =
                                      await withdrawStoreData.withdrawMoney(
                                          storeId:
                                              storeProvider.storeModel.storeId);
                                  if (success == 'success') {
                                    storeProvider.storeModel.wallet =
                                        (double.parse(
                                                    storeProvider
                                                        .storeModel.wallet) -
                                                double.parse(withdrawStoreData
                                                    .amountMoneyController
                                                    .text))
                                            .toString();
                                    await storeProvider.updateWallet(
                                      storeId: storeProvider.storeModel.storeId,
                                      amount: storeProvider.storeModel.wallet,
                                    );
                                    Navigator.of(context).pop();
                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        confirmBtnText: 'ตกลง');
                                  } else {
                                    Navigator.of(context).pop();
                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        title: 'ไม่สามารถทำรายการได้',
                                        confirmBtnText: 'ตกลง');
                                  }
                                });
                          } else {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                title: 'ยอดเงินไม่เพียงพอ',
                                confirmBtnText: 'ตกลง');
                          }
                        } else {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: 'กรุณากรอกข้อมูลให้ครบ',
                              confirmBtnText: 'ตกลง');
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
                        "ถอนเงิน",
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
  }
}
