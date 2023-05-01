import 'package:flutter/material.dart';
import 'package:sales/utils/keyboard_actions.dart';

// function to show done button in IOS devices
void showRemoveOverlay(BuildContext context, FocusNode? focusNode) {
  bool? hasFocus = focusNode?.hasFocus;
  KeyboardOverlay.removeOverlay();
  if (hasFocus ?? false) {
    KeyboardOverlay.showOverlay(context);
  } else {
    KeyboardOverlay.removeOverlay();
  }
}
