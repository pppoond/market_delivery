import 'package:flutter/material.dart';
import 'package:market_delivery/screens/store/store_location_screen.dart';
import 'package:market_delivery/screens/store/store_password_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../model/store.dart';

class StoreSettingScreen extends StatelessWidget {
  static const routeName = "/store-setting-screen";
  Widget drawerItem({required String title, var leadingIcon, required onTap}) {
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: ListTile(
        leading: leadingIcon == null ? null : leadingIcon,
        title: Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        trailing: title == "Log Out"
            ? null
            : Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.white,
              ),
        dense: true,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<Stores>(context, listen: false);
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
                  'การตั้งค่า',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                child: Consumer<Stores>(
                  builder: (context, storeData, child) => Center(
                    child: Column(
                      children: [
                        drawerItem(
                            leadingIcon: Icon(Icons.location_on_sharp),
                            title: "ตำแหน่งร้าน",
                            onTap: () async {
                              var status = await Permission.location.status;
                              if (status.isDenied) {
                                await Permission.location.request();
                              }
                              Navigator.of(context)
                                  .pushNamed(StoreLocationScreen.routeName);
                            }),
                        Divider(
                          color: Colors.white,
                        ),
                        drawerItem(
                            leadingIcon: Icon(
                              Icons.lock,
                            ),
                            title: "รหัสผ่าน",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(StorePasswordScreen.routeName);
                            }),
                        Divider(
                          color: Colors.white,
                        ),
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
