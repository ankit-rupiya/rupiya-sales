import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/constants/text_styles.dart';
import 'package:sales/core/elevated_buttons.dart';

class RSDialog extends StatelessWidget {
  final Widget? body;
  final String? title;
  final String? message;
  final List<RSElevatedButton> actions;
  final Axis actionArrangement;
  const RSDialog(
      {super.key,
      this.title,
      this.body,
      this.message,
      required this.actions,
      this.actionArrangement = Axis.vertical})
      : assert(body != null || message != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      content: Container(
        margin: const EdgeInsets.all(20),
        width: Get.width * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: body ??
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: RSTextStyles.bodyBold.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
              ),
              const SizedBox.square(
                dimension: 20,
              ),
              if (actionArrangement == Axis.vertical)
                ...actions
                    .map<Widget>((button) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: button,
                        ))
                    .toList(),
              if (actionArrangement == Axis.horizontal)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions
                          .map<Widget>((button) => Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: button,
                              ))
                          .toList(),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
