import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  String hintText;
  var icon;
  TextEditingController controller;
  Function(String)? onChanged;
  bool readOnly;
  bool enableInteractiveSelection;
  bool enabled;
  bool obscureText;
  bool suffixIconEndable;
  Color color;
  // String initialValue;
  TextFieldWidget(
      {required this.hintText,
      this.icon,
      required this.controller,
      this.onChanged,
      this.readOnly = false,
      this.enableInteractiveSelection = true,
      this.enabled = true,
      this.obscureText = false,
      this.suffixIconEndable = false,
      this.color = Colors.white
      // this.initialValue = "",
      });

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        // initialValue: widget.initialValue != null ? widget.initialValue : null,
        obscureText: widget.obscureText,
        // enableInteractiveSelection: widget.enableInteractiveSelection,
        focusNode: FocusNode(),
        readOnly: widget.readOnly,
        onChanged: widget.onChanged,
        controller: widget.controller,
        decoration: InputDecoration(
          enabled: widget.enabled,
          isDense: true,
          filled: true,
          fillColor: (widget.enabled)
              ? Colors.grey.shade100
              : (widget.color != null)
                  ? widget.color
                  : Colors.red.shade300,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          prefixIcon: (widget.suffixIconEndable == false)
              ? (widget.icon == null)
                  ? null
                  : widget.icon
              : null,
          suffixIcon: (widget.suffixIconEndable)
              ? (widget.icon == null)
                  ? null
                  : widget.icon
              : null,
          // icon: (icon == null) ? null : icon,
          hintText: widget.hintText,
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
}
