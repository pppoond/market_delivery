import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:market_delivery/model/post.dart';
import 'package:market_delivery/screens/store/edit_post_screen.dart';
import 'package:market_delivery/utils/api.dart';
import 'package:provider/provider.dart';

class PostList extends StatelessWidget {
  bool? storePost;
  PostList({this.storePost = false});
  @override
  Widget build(BuildContext context) {
    final postPrivider = Provider.of<Posts>(context, listen: false);
    postPrivider.getPostByStoreId();
    if (storePost == true) {
      return Consumer<Posts>(
        builder: (context, postData, child) => ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: postData.listPostStore.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    // color: Colors.amber,
                    ),
                margin: EdgeInsets.symmetric(vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            radius: 20,
                            backgroundImage: (postData.listPostStore[index]
                                        .storeId.profileImage !=
                                    null)
                                ? (postData.listPostStore[index].storeId
                                            .profileImage !=
                                        "")
                                    ? NetworkImage(
                                        Api.imageUrl +
                                            'profiles/' +
                                            postData.listPostStore[index]
                                                .storeId.profileImage,
                                      )
                                    : AssetImage("assets/images/user.png")
                                        as ImageProvider

                                // :NetworkImage(
                                //     Api.imageUrl +
                                //         customerData.customerModel!.profileImage,
                                //   )
                                : AssetImage("assets/images/user.png"),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            postData.listPostStore[index].storeId.storeName,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoActionSheet(
                                    title: const Text('ตัวเลือก'),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        child: const Text('แก้ไข'),
                                        onPressed: () async {
                                          await Navigator.of(context).pushNamed(
                                              EditPostScreen.routeName);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: const Text(
                                          'ลบ',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () async {
                                          CoolAlert.show(
                                              context: context,
                                              type: CoolAlertType.confirm,
                                              confirmBtnText: 'ยืนยัน',
                                              title: 'ต้องการลบหรือไม่',
                                              cancelBtnText: 'ยกเลิก',
                                              onConfirmBtnTap: () async {
                                                String success =
                                                    await postData.deletePost(
                                                        postId: postData
                                                            .listPostStore[
                                                                index]
                                                            .postId);
                                                if (success == 'success') {
                                                  Navigator.pop(context);
                                                  await CoolAlert.show(
                                                      context: context,
                                                      type:
                                                          CoolAlertType.success,
                                                      confirmBtnText: 'ตกลง');
                                                  Navigator.pop(context);
                                                } else {
                                                  Navigator.pop(context);
                                                  await CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType.error,
                                                      confirmBtnText: 'ตกลง');
                                                  Navigator.pop(context);
                                                }
                                              });
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(Icons.more_vert))
                        ],
                      ),
                    ),
                    Container(
                      child: ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        onPageChanged: (value) {
                          debugPrint('Page changed: $value');
                        },
                        autoPlayInterval: 5000,
                        isLoop: true,
                        children: [
                          for (var item in postData.listPostStore[index].images)
                            Image.network(
                              Api.imageUrl + 'posts/' + '$item',
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(
                                text: postData.listPostStore[index].message)
                          ])),
                    ),
                    SizedBox(height: 7),
                    Divider(),
                  ],
                ),
              );
            }),
      );
    } else {
      return Consumer<Posts>(
        builder: (context, postData, child) => ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: postData.listPostStore.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    // color: Colors.amber,
                    ),
                margin: EdgeInsets.symmetric(vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            radius: 20,
                            backgroundImage: (postData
                                        .listPost[index].storeId.profileImage !=
                                    null)
                                ? (postData.listPost[index].storeId
                                            .profileImage !=
                                        "")
                                    ? NetworkImage(
                                        Api.imageUrl +
                                            'profiles/' +
                                            postData.listPostStore[index]
                                                .storeId.profileImage,
                                      )
                                    : AssetImage("assets/images/user.png")
                                        as ImageProvider

                                // :NetworkImage(
                                //     Api.imageUrl +
                                //         customerData.customerModel!.profileImage,
                                //   )
                                : AssetImage("assets/images/user.png"),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            postData.listPost[index].storeId.storeName,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      child: ImageSlideshow(
                        width: double.infinity,
                        height: 200,
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        onPageChanged: (value) {
                          debugPrint('Page changed: $value');
                        },
                        autoPlayInterval: 5000,
                        isLoop: true,
                        children: [
                          for (var item in postData.listPost[index].images)
                            Image.network(
                              Api.imageUrl + 'posts/' + '$item',
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                            TextSpan(text: postData.listPost[index].message)
                          ])),
                    ),
                    SizedBox(height: 7),
                    Divider(),
                  ],
                ),
              );
            }),
      );
    }
  }
}
