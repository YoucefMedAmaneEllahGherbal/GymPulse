import 'package:flutter/material.dart';

const kBackgroundColor = Colors.black;
const kSecondaryColor = Color(0xFF292929);
const kAccentColor = Color(0xFFF1FF33);
const kLightAccentColor = Color(0xFFFFFFB3);

const kTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(borderRadius:  BorderRadius.all(Radius.circular(15))),
  hintText: "enter your text",
  filled: true,
  fillColor: kLightAccentColor,
);
