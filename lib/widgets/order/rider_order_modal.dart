import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RiderOrderModal {
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
            return Container(
              height: MediaQuery.of(ctx).size.height * 0.8,
              decoration: BoxDecoration(
                color: Color(0xff757575),
                border: Border(
                  top: BorderSide(
                    width: 0,
                    color: Color(0xff757575),
                  ),
                ),
              ),
              child: Container(
                color: Colors.amber,
                child: Column(
                  children: [Text("คำสั่งซื้อ")],
                ),
              ),
            );
          });
        });
  }
}
