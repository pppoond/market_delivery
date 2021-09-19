import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../model/product.dart';
import '../../widgets/product_list_item.dart';

class ProductManagementScreen extends StatelessWidget {
  static const routeName = "/product-management-screen";
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    products.getProduct(storeId: "1");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 1,
        title: Text("จัดการสินค้า"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 7),
        children: [
          SizedBox(
            height: 7,
          ),
          Text(
            "รายการสินค้า",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 7,
          ),
          Consumer<Products>(
            builder: (context, productData, child) => Column(
              children: [
                productData.products.isNotEmpty
                    ? ListView.builder(
                        itemCount: productData.products.length > 0
                            ? productData.products.length
                            : 0,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Container(
                              margin: EdgeInsets.only(bottom: 7),
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: i.floor().isEven
                                      ? Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.3)
                                      : Colors.grey.shade300),
                              child: ProductListItem(
                                product: productData.products[i],
                              ));
                        })
                    : Center(
                        child: Text("ไม่มีสินค้า"),
                      ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            TextButton(
              style: ButtonStyle(
                // side: MaterialStateProperty.all(BorderRadius.all(12)),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).accentColor),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "เพิ่มสินค้า",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            OutlinedButton(
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                  ),
                  Text(
                    "เพิ่มสินค้า",
                    style: TextStyle(),
                  )
                ],
              ),
              // onPressed: outlinedBtnState ? () {} : null,
              onPressed: () {},
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey;
                  } else {
                    return Colors.red;
                  }
                },
              ), side: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return BorderSide(color: Colors.grey);
                } else {
                  return BorderSide(color: Colors.red);
                }
              })),
            ),
            Container(
              // padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(16)),
              child: TextButton(
                clipBehavior: Clip.none,
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      "เพิ่มสินค้า",
                      style: TextStyle(
                          // fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
