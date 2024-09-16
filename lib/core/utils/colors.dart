import 'package:flutter/material.dart';

const Color kBlack = Color(0xFF000000);
const Color kPrimary = Color(0xFF011826);
const Color kSecondary = Color(0xFF3F6E8C);
const Color kGreen = Color(0xFF008800);
const Color kError = Color(0xFFFF2525);
const Color kWhite = Color(0xFFFFFFFF);
const Color kDisabledButton = Color(0xFFB6B6B6);



const Color kHintColor = Color(0xFFB6B6B6);




extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    var color = hexColorString;
    color = color.replaceAll('#', '');
    if (color.length == 6) {
      color = 'FF$color';
    }

    return Color(int.parse(color, radix: 16));
  }
}
