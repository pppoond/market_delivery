import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitchWidget extends StatefulWidget {
  bool isActive;
  Function(bool) onToggle;
  CustomSwitchWidget({this.isActive = false, required this.onToggle});

  @override
  _CustomSwitchWidgetState createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      height: 30,
      showOnOff: true,
      toggleSize: 15,
      activeText: "เปิด",
      inactiveText: "ปิด",
      activeTextFontWeight: FontWeight.normal,
      inactiveTextFontWeight: FontWeight.normal,
      activeTextColor: Colors.white,
      inactiveTextColor: Colors.white,
      value: widget.isActive,
      onToggle: (value) {
        setState(() {
          widget.isActive = value;
        });
      },
      activeColor: Theme.of(context).accentColor,
    );
  }
}
