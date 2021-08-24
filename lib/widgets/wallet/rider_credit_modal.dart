import 'package:flutter/material.dart';
import 'package:market_delivery/widgets/text_field_widget.dart';

class RiderCreditModal {
  static Future<dynamic> showModal({
    required BuildContext ctx,
    required String orderId,
  }) {
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
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ถอนเครดิตเข้ากระเป๋าเงิน",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "เครดิต 500",
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
                    TextFieldWidget(
                        icon: null,
                        hintText: "จำนวนเครดิต",
                        controller: textFieldController),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
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
            );
          });
        });
  }
}
