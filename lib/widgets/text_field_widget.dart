import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
    this.hintText,
    this.keyboardType,
    this.obscTxt,
    this.changeValue,
    [this.controller, this.focusNode , this.submitValue]
  );
  final String hintText;
  final ValueChanged<String> changeValue;
  final TextInputType keyboardType;
  final bool obscTxt;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? submitValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: TextField(
        obscureText: obscTxt,
        onChanged: changeValue,
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        decoration: kTextFieldDecoration.copyWith(hintText: hintText),
        controller: controller,
        focusNode: focusNode,
        onSubmitted: submitValue,
      ),
    );
  }
}
