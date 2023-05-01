import 'package:flutter/material.dart';
import 'package:sales/constants/colors.dart';

class RSTextStyles {
  static const TextStyle h1 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 18,
  );
  static const TextStyle h2 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 219, 216, 208),
    fontSize: 16,
  );
  static const TextStyle body = TextStyle(
    color: RSColor.bodyTextColor,
  );
  static const TextStyle bodyBold =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
}
