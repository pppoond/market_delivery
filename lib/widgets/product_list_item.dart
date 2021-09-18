import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../widgets/product/product_modal.dart';

import '../../utils/api.dart';

import '../../model/product.dart';

import 'custom_switch_widget.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  ProductListItem({required this.product});
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Container(
      // padding: EdgeInsets.only(bottom: 7, top: 7),
      decoration: BoxDecoration(
          // border: Border(bottom: BorderSide(width: 0.2)),
          color: Colors.transparent),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: ClipRRect(
              child: Image.network(
                Api.imageUrl +
                    "products/" +
                    product.productImages![0].proImgAddr.toString(),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(4),
              //   topRight: Radius.circular(4),
              // ),
              borderRadius: BorderRadius.circular(7),
            ),
            width: 85,
            height: 85,
          ),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.productName}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${product.productDetail}",
                    overflow: TextOverflow.ellipsis,
                    // style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "฿30",
                    // style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                "สถานะ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7,
              ),
              CustomSwitchWidget(
                onToggle: (value) {},
                isActive: false,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "พร้อมขาย",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
          Container(
            child: IconButton(
                onPressed: () {
                  showCupertinoDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          actions: [
                            CupertinoActionSheetAction(
                                onPressed: () {
                                  ProductModal.showModal(
                                      context: context, productId: "1");
                                },
                                child: Text("แก้ไข")),
                            CupertinoActionSheetAction(
                                onPressed: () {}, child: Text("ลบ")),
                            CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "ยกเลิก",
                                  style: TextStyle(color: Colors.redAccent),
                                )),
                          ],
                        );
                      });
                },
                icon: Icon(Icons.more_vert)),
          ),
        ],
      ),
    );
  }
}
