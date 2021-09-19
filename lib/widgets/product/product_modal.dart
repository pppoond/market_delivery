import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/widgets/text_field_widget.dart';

import 'package:provider/provider.dart';

import '../../utils/api.dart';
import '../../model/product.dart';

class ProductModal {
  static Future<dynamic> showModal({
    required BuildContext context,
    required String productId,
  }) async {
    final products = Provider.of<Products>(context, listen: false);
    Product model = await products.findById(productId: productId);
    products.productIdController = TextEditingController(text: model.productId);
    products.storeIdController = TextEditingController(text: model.storeId);

    products.categoryIdController =
        TextEditingController(text: model.categoryId);

    products.productNameController =
        TextEditingController(text: model.productName);

    products.productDetailController =
        TextEditingController(text: model.productDetail);

    products.statusController = TextEditingController(text: model.status);

    return showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.55),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          final _deviceSize = MediaQuery.of(context).size;
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(7),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Consumer<Products>(builder: (context, productData, child) {
                // var product = productData.findById(productId: productId);
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: (model != null)
                      ? Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: ListView(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "ยกเลิก",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              )),
                                          Text(
                                            "แก้ไข",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "บันทึก",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Container(
                                      height: _deviceSize.height * 0.2,
                                      child: ListView.builder(
                                          physics: ScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              model.productImages!.length > 0
                                                  ? model.productImages!.length
                                                  : 0,
                                          itemBuilder: (context, i) {
                                            return i == 0
                                                ? Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 7),
                                                        child: InkWell(
                                                          onTap: () {
                                                            print(
                                                                "Select Photo");
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(Icons
                                                                    .photo_camera),
                                                                Text(
                                                                    "เพิ่มรูปภาพ")
                                                              ],
                                                            ),
                                                            width: _deviceSize
                                                                    .width *
                                                                0.2,
                                                            height: _deviceSize
                                                                    .width *
                                                                0.2,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 7),
                                                        child: Container(
                                                          child: ClipRRect(
                                                            child:
                                                                Image.network(
                                                              Api.imageUrl +
                                                                  "products/" +
                                                                  model
                                                                      .productImages![
                                                                          0]
                                                                      .proImgAddr
                                                                      .toString(),
                                                              fit: BoxFit.cover,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                            ),
                                                            // borderRadius: BorderRadius.only(
                                                            //   topLeft: Radius.circular(4),
                                                            //   topRight: Radius.circular(4),
                                                            // ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                          width: _deviceSize
                                                                  .width *
                                                              0.5,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        left: 7),
                                                    child: Container(
                                                      child: ClipRRect(
                                                        child: Image.network(
                                                          Api.imageUrl +
                                                              "products/" +
                                                              model
                                                                  .productImages![
                                                                      0]
                                                                  .proImgAddr
                                                                  .toString(),
                                                          fit: BoxFit.cover,
                                                          alignment:
                                                              Alignment.center,
                                                        ),
                                                        // borderRadius: BorderRadius.only(
                                                        //   topLeft: Radius.circular(4),
                                                        //   topRight: Radius.circular(4),
                                                        // ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      width: _deviceSize.width *
                                                          0.5,
                                                    ),
                                                  );
                                          }),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 7),
                                      child: Column(
                                        children: [
                                          TextFieldWidget(
                                              icon: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7),
                                                    child: Text(
                                                      "รหัสสินค้า : ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              hintText: "รหัสสินค้า",
                                              controller: productData
                                                  .productIdController),
                                          TextFieldWidget(
                                              icon: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7),
                                                    child: Text(
                                                      "รหัสร้าน : ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              hintText: "รหัสร้าน",
                                              controller: productData
                                                  .storeIdController),
                                          TextFieldWidget(
                                              icon: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7),
                                                    child: Text(
                                                      "ประเภทสินค้า : ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              hintText: "ประเภทสินค้า",
                                              controller: productData
                                                  .categoryIdController),
                                          TextFieldWidget(
                                              icon: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7),
                                                    child: Text(
                                                      "ชื่อสินค้า : ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              hintText: "ชื่อสินค้า",
                                              controller: productData
                                                  .productNameController),
                                          TextFieldWidget(
                                              icon: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 7),
                                                    child: Text(
                                                      "รายละเอียดสินค้า : ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              hintText: "รายละเอียดสินค้า",
                                              controller: productData
                                                  .productDetailController),
                                          TextField(
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText:
                                                        "Enter your text here"),
                                            controller: productData
                                                .productDetailController,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
