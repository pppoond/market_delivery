import 'package:flutter/material.dart';
import 'package:market_delivery/utils/api.dart';

import '../../model/product.dart';

class ProductDetailListItem extends StatelessWidget {
  Product product;

  ProductDetailListItem({
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    // print(foodImage);
    final _deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        // DetailListModal.showModal(
        //     context, id, foodTitle, foodPrice, foodImage, restaurantTitle);
      },
      child: Card(
        key: ValueKey(product.productId),
        elevation: 0,
        shadowColor: Colors.grey.shade200,
        child: Container(
          height: _deviceSize.height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _deviceSize.width * 0.35,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: Image.network(
                      Api.imageUrl +
                          "products/" +
                          product.productImages![0].proImgAddr,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "฿${double.parse(product.price).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 22,
                width: 22,
                margin: EdgeInsets.only(top: 10, right: 10),
                padding: EdgeInsets.only(bottom: 2, left: 0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.shade500,
                    style: BorderStyle.solid,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "+",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
