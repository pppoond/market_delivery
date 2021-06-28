import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailListModal {
  static Future<dynamic> showModal(BuildContext ctx, String id, String title,
      double price, String image, String restaurant) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(ctx).size.height * 0.8,
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
                      Image.network(image),
                      SizedBox(height: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${price.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(ctx).accentColor,
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(ctx).accentColor,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
