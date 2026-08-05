import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(this.hintText);
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: TextField(
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        decoration: kTextFieldDecoration.copyWith(
          hintText: hintText,
        ),
      ),
    );
  }
}
