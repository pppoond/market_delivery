import 'package:flutter/material.dart';

import '../screens/detail_screen.dart';

class FavoriteListItem extends StatelessWidget {
  final String resId;
  final String resImage;
  final String resTitle;

  FavoriteListItem({
    required this.resId,
    required this.resImage,
    required this.resTitle,
  });

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          DetailScreen.routeName,
          arguments: resId,
        );
      },
      child: Card(
        key: ValueKey(resId),
        elevation: 0.5,
        shadowColor: Colors.grey.shade200,
        child: Column(
          children: [
            Container(
              child: ClipRRect(
                child: GridTile(
                  header: GridTileBar(
                    // backgroundColor: Colors.black.withOpacity(0.35),
                    title: Text(""),
                    // subtitle: Text("SubTitle"),
                    trailing: Icon(
                      Icons.favorite,
                      color: Colors.red.shade400,
                    ),
                  ),

                  child: Image.network(
                    resImage,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  // footer: GridTileBar(
                  //   backgroundColor: Colors.black.withOpacity(0.35),
                  //   title: Text("Hello"),
                  //   subtitle: Text("SubTitle"),
                  //   trailing: Icon(
                  //     Icons.favorite,
                  //     color: Colors.red.shade400,
                  //   ),
                  // ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              width: _deviceSize.width * 0.42,
              height: _deviceSize.height * 0.13,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              width: _deviceSize.width * 0.42,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
