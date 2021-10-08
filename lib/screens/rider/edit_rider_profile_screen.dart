import 'package:flutter/material.dart';
import '../../utils/api.dart';

import 'package:provider/provider.dart';

import '../../model/rider.dart';

class EditRiderProfileScreen extends StatelessWidget {
  static const routeName = "/edit-rider-profile-screen";
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
                  'แก้ไขข้อมูลส่วนตัว',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: SafeArea(
                child: Consumer<Riders>(
                  builder: (context, riderData, child) => Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          radius: 50,
                          backgroundImage: (riderData.file != null)
                              ? FileImage(riderData.file!)
                              : (riderData.riderModel?.profileImage != null)
                                  ? (riderData.riderModel?.profileImage != "")
                                      ? NetworkImage(Api.imageUrl +
                                          riderData.riderModel!.profileImage)
                                      : AssetImage("assets/images/user.png")
                                          as ImageProvider
                                  : AssetImage("assets/images/user.png"),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // color: Colors.black.withOpacity(0.5),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black87.withOpacity(.5),
                                        Colors.transparent
                                      ],
                                      begin: const FractionalOffset(0.0, 0.5),
                                      end: const FractionalOffset(0.0, 0.0),
                                      stops: [0.0, 0.0],
                                      tileMode: TileMode.clamp),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    print("Select Image");
                                    // showAlertImage(
                                    //   title: "",
                                    //   content: "",
                                    //   context: context,
                                    //   defaultActionText: "Camera",
                                    //   cancelActionText: "Gallary",
                                    // );
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white38,
                                    size: 27,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                        Text(
                                          "ข้อมูลพื้นฐาน",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        userInputField(
                                          context: context,
                                          hintText: 'ชื่อ',
                                          labelText: 'ชื่อ',
                                          obscureText: false,
                                          controller:
                                              riderData.riderNameController,
                                        ),
                                        userInputField(
                                          context: context,
                                          hintText: 'Username',
                                          labelText: 'Username',
                                          obscureText: false,
                                          controller:
                                              riderData.usernameController,
                                        ),
                                        userInputField(
                                          context: context,
                                          hintText: 'Phone',
                                          labelText: 'Phone',
                                          obscureText: false,
                                          controller:
                                              riderData.riderPhoneController,
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
                      onPressed: () {},
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
