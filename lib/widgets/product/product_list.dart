import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';
import './product_list_item.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    products.getAllProduct();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "รายการ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(MenuScreen.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "รายการทั้งหมด",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.355,
            child: Consumer<Products>(
              builder: (context, productData, child) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productData.allProducts.length > 0
                      ? productData.allProducts.length
                      : 0,
                  itemBuilder: (context, i) =>
                      ProductListItem(product: productData.allProducts[i])),
            ),
          )
        ],
      ),
    );
  }
}
