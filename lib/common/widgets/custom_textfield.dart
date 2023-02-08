import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  bool obscureText;
  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black38,
        )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black38,
        )),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        } else if (widget.hintText == 'Email') {
          if (!RegExp(r'^[A-Za-z0-9]+@([a-z]+(\.[a-z]+)+)').hasMatch(val)) {
            return 'Enter Valid Email';
          }
        } else if (widget.hintText == 'Name') {
          if (!RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
            return 'Enter Valid Name';
          }
        } else {
          if (val.length < 6) {
            return 'Password must be atleast 6 characters!';
          }
        }
        return null;
      },
    );
  }
}
