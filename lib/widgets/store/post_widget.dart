import 'package:flutter/material.dart';
import 'package:market_delivery/model/post.dart';
import 'package:market_delivery/widgets/store/post_image_list.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<Posts>(context, listen: false);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Consumer<Posts>(
              builder: (context, postData, child) => Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ข่าวสาร',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PostImageList(),
                          TextField(
                            controller: postProvider.messageController,
                            keyboardType: TextInputType.multiline,
                            minLines: 4,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "รายละเอียด...",
                              labelText: 'รายละเอียด',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            postProvider.addPost();
                          },
                          child: Container(
                              padding: EdgeInsets.all(7),
                              child: Text(
                                'โพสต์',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
