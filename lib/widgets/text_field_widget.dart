import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  String hintText;
  Icon? icon;
  TextEditingController controller;
  Function(String)? onChanged;
  bool readOnly;
  bool enableInteractiveSelection;
  bool enabled;
  bool obscureText;
  TextFieldWidget({
    required this.hintText,
    this.icon,
    required this.controller,
    this.onChanged,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.enabled = true,
    this.obscureText = false,
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
          fillColor:
              (widget.enabled) ? Colors.grey.shade100 : Colors.grey.shade300,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          prefixIcon: (widget.icon == null) ? null : widget.icon,
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
