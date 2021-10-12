import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:market_delivery/model/store.dart';
import 'package:provider/provider.dart';

import 'package:provider/src/provider.dart';

import '../widgets/product/product_modal.dart';
import '../model/product_image.dart';

import '../../utils/api.dart';

import '../../model/product.dart';

import 'custom_switch_widget.dart';

class ProductListItem extends StatelessWidget {
  Product product;

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
              borderRadius: BorderRadius.circular(12),
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
              Consumer<Products>(
                builder: (context, productData, child) => CustomSwitchWidget(
                  onToggle: (value) {
                    if (value == true) {
                      product.status = "1";
                    } else {
                      product.status = "0";
                    }
                    print(value);
                    productData.updateStatus(
                        productId: product.productId, status: product.status);
                    // productData.notifyListeners();
                  },
                  isActive: product.status == "1" ? true : false,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Consumer<Products>(
                builder: (context, productData, child) => Text(
                  product.status == "1" ? "พร้อม" : "ไม่พร้อม",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: product.status == "1"
                          ? Theme.of(context).accentColor
                          : Colors.grey),
                ),
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
                                onPressed: () async {
                                  await Provider.of<ProductImages>(context,
                                          listen: false)
                                      .resetFile();

                                  await ProductModal.showModal(
                                      context: context,
                                      productId: product.productId);
                                },
                                child: Text("แก้ไข")),
                            CupertinoActionSheetAction(
                                onPressed: () async {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.confirm,
                                      cancelBtnText: 'ยกเลิก',
                                      confirmBtnText: 'ยืนยัน',
                                      title: 'ยืนยันเพื่อลบสินค้า',
                                      onConfirmBtnTap: () async {
                                        String success =
                                            await Provider.of<Products>(context,
                                                    listen: false)
                                                .deleteProduct(
                                                    productId:
                                                        product.productId);

                                        if (success == 'success') {
                                          Navigator.of(context).pop();
                                          await CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.success,
                                            confirmBtnText: 'ตกลง',
                                          );
                                          await Provider.of<Products>(context,
                                                  listen: false)
                                              .getProduct(
                                                  storeId: Provider.of<Stores>(
                                                          context,
                                                          listen: false)
                                                      .storeModel
                                                      .storeId);
                                        } else {
                                          Navigator.of(context).pop();
                                          await CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            confirmBtnText: 'ตกลง',
                                          );
                                        }
                                        Navigator.of(context).pop();
                                      });
                                },
                                child: Text("ลบ")),
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
