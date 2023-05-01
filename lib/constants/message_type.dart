import 'package:flutter/material.dart';

enum SnackBarType {
  success(Colors.green, Colors.white),
  error(Color(0xFFBA1A1A), Colors.white),
  warning(Colors.amber, Colors.white);

  final Color background, text;
  const SnackBarType(this.background, this.text);
}
