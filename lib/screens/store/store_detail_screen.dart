import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_delivery/model/product.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:market_delivery/widgets/product/product_detail_list_item.dart';
import 'package:market_delivery/widgets/product/product_list_item.dart';
import '../../model/store.dart';

import 'package:provider/provider.dart';

import '../../screens/cart_screen.dart';

import '../../model/cart.dart';
import '../../model/restaurants.dart';

import '../../widgets/badge.dart';
import '../../widgets/detail_list_item.dart';

class StoreDetailScreen extends StatelessWidget {
  static const routeName = "/store-detail-screen";

  @override
  Widget build(BuildContext context) {
    final storeId = ModalRoute.of(context)!.settings.arguments as String;

    final stores = Provider.of<Stores>(context, listen: false);
    final products = Provider.of<Products>(context, listen: false);

    stores.findById(storeId: storeId);
    products.getProduct(storeId: storeId);

    final _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        elevation: 0,
        backgroundColor: Colors.white,
        // title: Text("Detail"),
        actions: [
          Consumer<Cart>(
            builder: (ctx, cartData, child) {
              if (cartData.cart.length < 1) {
                return IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                );
              }
              return Badge(
                color: Colors.red,
                value: cartData.cart.length.toString(),
                child: child,
              );
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<Stores>(builder: (context, storeData, child) {
        return Container(
            child: storeData.storeModel.storeId != null
                ? storeData.storeModel.storeId != ''
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ListView(
                          children: [
                            Text(
                              "${storeData.storeModel.storeName}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: _deviceSize.height * 0.32,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: storeData.storeModel.profileImage !=
                                            null &&
                                        storeData.storeModel.profileImage != ''
                                    ? Image.network(
                                        Api.imageUrl +
                                            "stores/" +
                                            storeData.storeModel.profileImage,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      )
                                    : Image.asset(
                                        "assets/images/404.png",
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Distance 3.2 km",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                ),
                                Spacer(),
                                // Consumer<Restaurants>(
                                //   builder: (_, res, child) {
                                //     return IconButton(
                                //       onPressed: () {
                                //         // print(resData.isFavorite);
                                //         res.toggleFavorite(
                                //             resData.id, resData.isFavorite);
                                //       },
                                //       icon: Icon(
                                //         (resData.isFavorite)
                                //             ? Icons.favorite
                                //             : Icons.favorite_border,
                                //         color: (resData.isFavorite)
                                //             ? Colors.red.shade400
                                //             : Colors.grey.shade400,
                                //       ),
                                //     );
                                //   },
                                // )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "รายการอาหาร",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Consumer<Products>(
                              builder: (context, productData, child) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: productData.products.length,
                                  itemBuilder: (ctx, i) =>
                                      ProductDetailListItem(
                                    product: productData.products[i],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : Center(child: CircularProgressIndicator())
                : Center(child: CircularProgressIndicator()));
      }),
    );
  }

  void findById({required BuildContext context}) async {
    final resId = ModalRoute.of(context)!.settings.arguments as String;
    final stores = Provider.of<Stores>(context, listen: false);
  }

  productModal() async {
    // return
  }
}
