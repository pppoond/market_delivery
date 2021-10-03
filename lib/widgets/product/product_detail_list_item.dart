import 'package:flutter/material.dart';
import 'package:market_delivery/model/cart.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';
import '../detail_list_modal.dart';

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
        showModal(
          context: context,
          product: product,
        );
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

  Future<dynamic> showModal(
      {required BuildContext context, required Product product}) {
    int _counter = 1;
    double _calculatePrice = double.parse(product.price);

    final cart = Provider.of<Cart>(context, listen: false);

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void itemCount(value) {
              setState(() {
                if (value == "+") {
                  if (_counter > 9) {
                    return;
                  }
                  _counter = _counter + 1;
                } else {
                  if (_counter < 2) {
                    return;
                  }
                  _counter = _counter - 1;
                }
                _calculatePrice = _counter * double.parse(product.price);
                print(_calculatePrice);
              });
            }

            Widget counterButton(String icon) {
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(),
                ),
                onPressed: () {
                  itemCount(icon);
                },
                child: Container(
                  width: 45,
                  height: 45,
                  padding: EdgeInsets.only(bottom: 4, left: 1),
                  alignment: Alignment.center,
                  child: Text(
                    icon,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }

            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
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
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(Api.imageUrl +
                            "products/" +
                            product.productImages![0].proImgAddr),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [TextSpan(text: product.productName)],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          "฿${_calculatePrice.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        counterButton("-"),
                        Text(
                          "$_counter",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        counterButton("+"),
                      ],
                    ),
                    SafeArea(
                      child: Container(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).accentColor,
                          ),
                          onPressed: () {
                            cart.addProductToCart(
                                product: product, quantity: _counter);
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart),
                              Text(
                                "เพิ่มเข้าตะกร้า",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
