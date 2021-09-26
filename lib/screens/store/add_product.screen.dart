import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/product_image.dart';

import 'package:provider/provider.dart';

import '../../model/product.dart';
import '../../model/store.dart';

import '../../widgets/product/product_image_list.dart';
import '../../widgets/text_field_widget.dart';

class AddProductScreen extends StatelessWidget {
  static const routeName = "/add-product-screen";
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context, listen: false);
    final storeProvider = Provider.of<Stores>(context, listen: false);
    final productImageProvider =
        Provider.of<ProductImages>(context, listen: false);
    final _deviceSize = MediaQuery.of(context).size;
    final paddingGlobal = EdgeInsets.symmetric(horizontal: 16);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 0,
        centerTitle: true,
        // backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),

        title: Text("เพิ่มสินค้า"),
      ),
      body: Container(
        decoration: BoxDecoration(
            // color: Theme.of(context).accentColor.withOpacity(0.1)),
            color: Colors.grey.shade100),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                SizedBox(
                  height: 7,
                ),
                ProductImageList(),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: paddingGlobal,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: "ประเภทสินค้า",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 17))
                            ])),
                        SizedBox(
                          height: 7,
                        ),
                        userInputField(
                            context: context,
                            hintText: "ประเภทสินค้า...",
                            controller: productProvider.categoryIdController,
                            obscureText: false)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: paddingGlobal,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: "ชื่อสินค้า",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 17))
                            ])),
                        SizedBox(
                          height: 7,
                        ),
                        userInputField(
                            context: context,
                            hintText: "ชื่อสินค้า...",
                            controller: productProvider.productNameController,
                            obscureText: false)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: paddingGlobal,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  text: "รายละเอียดสินค้า",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 17))
                            ])),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: TextField(
                            controller: productProvider.productDetailController,
                            keyboardType: TextInputType.multiline,
                            minLines: 4,
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                                hintText: "รายละเอียดสินค้า..."),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: paddingGlobal,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                    TextSpan(
                                        text: "ราคา",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 17))
                                  ])),
                              SizedBox(
                                height: 7,
                              ),
                              userInputField(
                                  icon: IconButton(
                                      onPressed: null,
                                      icon: Text(
                                        "฿",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color:
                                                Theme.of(context).accentColor),
                                      )),
                                  context: context,
                                  hintText: "ราคา...",
                                  obscureText: false,
                                  controller: productProvider.priceController)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                    TextSpan(
                                        text: "หน่วย",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 17))
                                  ])),
                              SizedBox(
                                height: 7,
                              ),
                              userInputField(
                                  context: context,
                                  hintText: "หน่วย กรัม กีโลกรัม อื่นๆ...",
                                  obscureText: false,
                                  controller: productProvider.priceController)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Theme.of(context).accentColor.withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: TextButton(
              onPressed: () async {
                bool validateForm = await productProvider.validateForm();
                if (validateForm == true) {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.confirm,
                      confirmBtnText: "ยืนยัน",
                      cancelBtnText: "ยกเลิก",
                      title: "คำเตือน!",
                      text: "ต้องการเพิ่มสินค้าหรือไม่?",
                      onConfirmBtnTap: () async {
                        var addProduct = await productProvider.addProduct(
                            storeId:
                                storeProvider.storeModel.storeId.toString(),
                            categoryId:
                                productProvider.categoryIdController.text,
                            productName:
                                productProvider.productNameController.text,
                            productDetail:
                                productProvider.productDetailController.text);

                        var addProductImage =
                            await productImageProvider.uploadImage(
                          context: context,
                          productId: addProduct['result']['product_id'],
                        );

                        if (addProduct['msg'] == 'success') {
                          CoolAlert.show(
                                  context: context, type: CoolAlertType.success)
                              .then((value) {
                            Navigator.of(context).pop();
                          });
                        } else {
                          CoolAlert.show(
                                  context: context, type: CoolAlertType.error)
                              .then((value) {
                            Navigator.of(context).pop();
                          });
                        }
                      });
                } else {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      title: 'คำเตือน!',
                      text: 'กรุณากรอกข้อมูลให้ครบ');
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
                "เพิ่มสินค้า",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userInputField(
      {required BuildContext context,
      required String hintText,
      var icon,
      TextEditingController? controller,
      required bool obscureText,
      Function(String)? onChanged}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          prefixIcon: (icon == null) ? null : icon,
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
}
