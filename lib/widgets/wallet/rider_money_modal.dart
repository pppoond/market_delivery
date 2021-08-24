import 'package:flutter/material.dart';
import 'package:market_delivery/widgets/text_field_widget.dart';

class RiderMoneyModal {
  static Future<dynamic> showModal({
    required BuildContext ctx,
    required String orderId,
  }) {
    String dropdownValue = 'ไทยพาณิช';
    TextEditingController textFieldController = TextEditingController();
    return showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.55),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: ctx,
        builder: (ctx) {
          return StatefulBuilder(builder: (ctx, setState) {
            return Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(ctx).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0),
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
                                "เงิน 1000",
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
                        hintText: "จำนวนเงิน",
                        controller: textFieldController),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Theme.of(ctx).accentColor),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'ไทยพาณิช',
                        'กสิกร',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          // child: Text(value),
                          child: Container(
                            width: MediaQuery.of(ctx).size.width * 0.8,
                            padding: EdgeInsets.all(7),
                            // color: Colors.red,
                            child: Row(
                              children: [
                                Text(value),
                                Spacer(),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        print(dropdownValue);
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
            );
          });
        });
  }
}
