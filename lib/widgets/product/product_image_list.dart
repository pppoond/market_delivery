import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import '../../model/product_image.dart';

class ProductImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Container(
        height: _deviceSize.height * 0.2,
        child: Consumer<ProductImages>(
            builder: (context, productImageData, child) {
          return productImageData.listFile.length > 0
              ? ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: productImageData.listFile.length > 0
                      ? productImageData.listFile.length
                      : 0,
                  itemBuilder: (context, i) {
                    return i == 0
                        ? Row(children: [
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              child: InkWell(
                                onTap: () {
                                  showCupertinoDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          actions: [
                                            CupertinoActionSheetAction(
                                                onPressed: () async {
                                                  await (context)
                                                      .read<ProductImages>()
                                                      .chooseImage(context,
                                                          ImageSource.camera)
                                                      .then((value) =>
                                                          Navigator.of(context)
                                                              .pop());
                                                },
                                                child: Text("กล้อง")),
                                            CupertinoActionSheetAction(
                                                onPressed: () async {
                                                  await (context)
                                                      .read<ProductImages>()
                                                      .chooseImage(context,
                                                          ImageSource.gallery)
                                                      .then((value) =>
                                                          Navigator.of(context)
                                                              .pop());
                                                },
                                                child: Text("แกลเลอรี่")),
                                            CupertinoActionSheetAction(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "ยกเลิก",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                          ],
                                        );
                                      });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.photo_camera),
                                          Text("เพิ่มรูปภาพ")
                                        ],
                                      ),
                                      width: _deviceSize.height * 0.2,
                                      // height: _deviceSize.width * 0.2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            productImageData.listFile.length > 0
                                ? ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        productImageData.listFile.length > 0
                                            ? productImageData.listFile.length
                                            : 0,
                                    itemBuilder: (context, i) => Container(
                                      margin: EdgeInsets.only(left: 7),
                                      child: InkWell(
                                        onTap: () {
                                          showCupertinoDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title: Text("คำเตือน!"),
                                                  content: Text(
                                                      "คุณต้องการลบหรือไม่?"),
                                                  actions: [
                                                    CupertinoActionSheetAction(
                                                        onPressed: () {
                                                          productImageData
                                                              .resetIndexFile(
                                                                  index: i)
                                                              .then((value) =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop());
                                                        },
                                                        child: Text("ลบ")),
                                                    CupertinoActionSheetAction(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          "ยกเลิก",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: Colors.grey.shade300),
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  child: Image.file(
                                                      productImageData
                                                          .listFile[i])),
                                              Positioned(
                                                  right: 0,
                                                  left: 0,
                                                  top: 0,
                                                  bottom: 0,
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 25,
                                                    color: Colors.white
                                                        .withOpacity(0.7),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox()
                          ])
                        : SizedBox();
                  })
              : ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, i) => Container(
                    margin: EdgeInsets.only(left: 16),
                    child: InkWell(
                      onTap: () {
                        showCupertinoDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                actions: [
                                  CupertinoActionSheetAction(
                                      onPressed: () async {
                                        await (context)
                                            .read<ProductImages>()
                                            .chooseImage(
                                                context, ImageSource.camera)
                                            .then((value) =>
                                                Navigator.of(context).pop());
                                      },
                                      child: Text("กล้อง")),
                                  CupertinoActionSheetAction(
                                      onPressed: () async {
                                        await (context)
                                            .read<ProductImages>()
                                            .chooseImage(
                                                context, ImageSource.gallery)
                                            .then((value) =>
                                                Navigator.of(context).pop());
                                      },
                                      child: Text("แกลเลอรี่")),
                                  CupertinoActionSheetAction(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "ยกเลิก",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              );
                            });
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo_camera),
                                Text("เพิ่มรูปภาพ")
                              ],
                            ),
                            width: _deviceSize.height * 0.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
