import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_delivery/model/post.dart';
import 'package:market_delivery/screens/store/store_setting_screen.dart';
import '../../utils/api.dart';

import 'package:provider/provider.dart';

import '../../model/store.dart';

class EditPostScreen extends StatelessWidget {
  static const routeName = "/edit-post-screen";
  Widget userInputField(
      {required BuildContext context,
      required String hintText,
      required String labelText,
      var icon,
      TextEditingController? controller,
      required bool obscureText}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          prefixIcon: (icon == null) ? null : icon,
          // icon: (icon == null) ? null : icon,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).accentColor)),
        ),
        // focusedBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //         width: 1, color: Theme.of(context).accentColor))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<Stores>(context, listen: false);
    final postProvider = Provider.of<Posts>(context, listen: false);
    String postId = ModalRoute.of(context)!.settings.arguments as String;
    postProvider.findById(postId: postId);
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
                  'แก้ไขข้อมูลร้าน',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(StoreSettingScreen.routeName);
                      },
                      icon: Icon(Icons.settings)),
                ],
              ),
              body: SafeArea(
                child: Consumer<Posts>(
                  builder: (context, postData, child) => Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
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
                                        TextField(
                                          controller:
                                              postProvider.messageController,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 4,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                            hintText: "รายละเอียด...",
                                            labelText: 'รายละเอียด',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
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
              bottomNavigationBar: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    child: TextButton(
                      onPressed: () async {
                        bool checkNull =
                            await storeProvider.checkNullControll();
                        if (checkNull == true) {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              text: 'ยืนยัน เพื่อบันทึกการเปลี่ยนแปลง',
                              title: 'ยืนยัน',
                              cancelBtnText: 'ยกเลิก',
                              confirmBtnText: 'ยืนยัน',
                              onConfirmBtnTap: () async {
                                var result = await storeProvider.updateStore();
                                if (result == 'success') {
                                  Navigator.of(context).pop();
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    confirmBtnText: 'ตกลง',
                                  );
                                } else {
                                  Navigator.of(context).pop();
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    confirmBtnText: 'ตกลง',
                                  );
                                }
                              });
                        } else {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: 'กรุณากรอกข้อมูลให้ครบ',
                              confirmBtnText: 'ตกลง');
                        }
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Theme.of(context).accentColor,
                        minimumSize: Size(
                          double.infinity,
                          50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "บันทึก",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
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
