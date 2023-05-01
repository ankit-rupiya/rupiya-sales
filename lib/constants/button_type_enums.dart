import 'package:flutter/material.dart';
import 'package:sales/constants/text_styles.dart';

enum RSButtonType {
  primary(Color(0xFFFCBB4A), 12, RSTextStyles.bodyBold),
  plain(Colors.black, 8, RSTextStyles.body),
  plainOnBlack(Color(0x11FFFFFF), 5, RSTextStyles.body),
  plainText(Color(0xFFFCBB4A), 12, RSTextStyles.body);

  final Color color;
  final double borderRadius;
  final TextStyle textStyle;

  const RSButtonType(this.color, this.borderRadius, this.textStyle);
}
