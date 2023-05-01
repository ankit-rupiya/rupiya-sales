import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sales/constants/typedefs.dart';
import 'package:sales/utils/show_remove_overlay.dart';

class RSTextField extends StatefulWidget {
  final TextInputAction textInputAction;
  final String label;
  final String? hint;
  final ValidatorCallback validation;
  final bool isPassword;
  final bool readOnly;
  final Iterable<String>? autofill;
  final TextInputType? keyboardType;
  final StringCallback onChange;
  final StringCallback onFieldSubmitted;
  final NullableStringCallback onSaved;
  final double? height;
  final double? width;
  final String? initialData;
  final List<TextInputFormatter>? inputFormatters;
  const RSTextField(
      {super.key,
      required this.label,
      this.hint,
      this.readOnly = false,
      this.onChange,
      this.onFieldSubmitted,
      this.onSaved,
      this.validation,
      this.textInputAction = TextInputAction.next,
      this.isPassword = false,
      this.autofill,
      this.keyboardType,
      this.initialData,
      this.height,
      this.width,
      this.inputFormatters});

  @override
  State<RSTextField> createState() => _RSTextFieldState();
}

class _RSTextFieldState extends State<RSTextField> {
  bool obscure = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    if (widget.isPassword) {
      setState(() {
        obscure = true;
      });
    }
    focusNode.addListener(() {
      if (Platform.isIOS &&
          (widget.keyboardType == TextInputType.phone ||
              widget.keyboardType == TextInputType.number)) {
        showRemoveOverlay(context, focusNode);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        focusNode: focusNode,
        readOnly: widget.readOnly,
        initialValue: widget.initialData,
        textInputAction: widget.textInputAction,
        onSaved: widget.onSaved,
        onChanged: widget.onChange,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: obscure,
        autofillHints: widget.autofill,
        keyboardType: widget.keyboardType,
        validator: widget.validation,
        decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hint,
          border: const OutlineInputBorder(gapPadding: 12),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon: obscure
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null,
        ),
      ),
    );
  }
}
