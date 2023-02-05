import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';

class CustomCheckBox extends StatefulWidget {
  bool value;
  void Function(bool?)? onChanged;
  CustomCheckBox({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }
        return GlobalVariables.secondaryColor;
      }),
      hoverColor: GlobalVariables.secondaryColor,
      checkColor: GlobalVariables.secondaryColor,
      focusColor: GlobalVariables.secondaryColor,
      activeColor: GlobalVariables.secondaryColor,
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
