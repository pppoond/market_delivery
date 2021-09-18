import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';

class ProductModal {
  static Future<dynamic> showModal({
    required BuildContext context,
    required String productId,
  }) {
    return showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.55),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(7),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Consumer<Products>(builder: (context, productData, child) {
                var product = productData.findById(productId: productId);
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: (product != null)
                      ? Column(
                          children: [Text("คำสั่งซื้อ")],
                        )
                      : Center(child: CircularProgressIndicator()),
                  // child: Center(child: CircularProgressIndicator()),
                );
              }),
            );
          });
        });
  }
}
