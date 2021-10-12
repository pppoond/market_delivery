import 'package:flutter/material.dart';
import 'package:market_delivery/model/withdraw_store.dart';
import 'package:provider/provider.dart';

class StoreWithdrawHistoryScreen extends StatelessWidget {
  static const routeName = "/store-withdraw-history-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                automaticallyImplyLeading: true,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                toolbarHeight: 45,
                elevation: 1,
                centerTitle: true,
                title: Text(
                  'ประวัติการทำรายการ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                child: Consumer<WithdrawStores>(
                  builder: (context, withdrawStoreData, child) => Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 16,
                                        ),
                                        ListView.builder(
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: withdrawStoreData
                                                .withdrawStores.length,
                                            itemBuilder: (context, i) {
                                              return Container(
                                                // padding: EdgeInsets.symmetric(
                                                //     vertical: 7),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              children: [
                                                                TextSpan(
                                                                    text: (i +
                                                                            1)
                                                                        .toString()),
                                                                TextSpan(
                                                                    text: ' '),
                                                                TextSpan(
                                                                    text: withdrawStoreData
                                                                        .withdrawStores[
                                                                            i]
                                                                        .bankName),
                                                                TextSpan(
                                                                    text: ' '),
                                                                TextSpan(
                                                                    text: withdrawStoreData
                                                                        .withdrawStores[
                                                                            i]
                                                                        .noBankAccount),
                                                              ]),
                                                        ),
                                                        Spacer(),
                                                        RichText(
                                                          text: TextSpan(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              children: [
                                                                withdrawStoreData
                                                                            .withdrawStores[
                                                                                i]
                                                                            .payStatus ==
                                                                        '0'
                                                                    ? TextSpan(
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontWeight: FontWeight
                                                                                .bold),
                                                                        text:
                                                                            "กำลังดำเนินการ")
                                                                    : TextSpan(
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .green,
                                                                            fontWeight: FontWeight
                                                                                .bold),
                                                                        text:
                                                                            "โอนสำเร็จ"),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider()
                                                  ],
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
